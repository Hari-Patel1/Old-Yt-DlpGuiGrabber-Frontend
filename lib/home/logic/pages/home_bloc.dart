import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter/services.dart";
import "package:shared_preferences/shared_preferences.dart";
import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchUrlFromClipboard>(_onFetchUrlFromClipboard);
    on<SetUrl>(_onSetUrl);
    on<UpdatePreferences>(_onUpdatePreferences);
    on<DownloadSubmitted>(_onDownloadSubmitted);
    on<LogAppended>(_onLogAppended);
    on<ClearLog>(_onClearLog);
  }

  Future<void> _onFetchUrlFromClipboard(
      FetchUrlFromClipboard event, Emitter<HomeState> emit) async {
    try {
      final data = await Clipboard.getData("text/plain");
      final clipboardText = data?.text ?? '';
      emit(state.copyWith(url: clipboardText));
      add(LogAppended("[*] URL fetched from clipboard.\n"));
    } catch (e) {
      add(LogAppended("[!] Failed to read from clipboard: $e\n"));
    }
  }

  Future<void> _onSetUrl(SetUrl event, Emitter<HomeState> emit) async {
    emit(state.copyWith(url: event.url));
  }

  Future<void> _onUpdatePreferences(
      UpdatePreferences event, Emitter<HomeState> emit) async {
    // Optional: persist preferences if needed
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("extension", event.selectedExtension);
    await prefs.setBool("audioOnly", event.audioOnly);
    await prefs.setString("audioQuality", event.selectedAudioQuality);
    await prefs.setString("videoQuality", event.selectedVideoQuality);
    await prefs.setBool("embedThumbnail", event.embedThumbnail);
    await prefs.setBool("downloadAlbumArt", event.downloadAlbumArt);
    await prefs.setBool("addMetadata", event.addMetadata);

    add(LogAppended("[*] Preferences updated.\n"));
  }

  Future<void> _onDownloadSubmitted(
      DownloadSubmitted event, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    final preferences = {
      "url": event.url,
      "extension": prefs.getString("extension") ?? "mp4",
      "audioOnly": prefs.getBool("audioOnly") ?? false,
      "audioQuality": prefs.getString("audioQuality") ?? "320k",
      "videoQuality": prefs.getString("videoQuality") ?? "1080p",
      "embedThumbnail": prefs.getBool("embedThumbnail") ?? true,
      "downloadAlbumArt": prefs.getBool("downloadAlbumArt") ?? true,
      "addMetadata": prefs.getBool("addMetadata") ?? true,
      "downloadDirectory": prefs.getString("download_directory"),
    };

    emit(state.copyWith(
      isDownloading: true,
      logOutput: "${state.logOutput}[*] Starting download...\n",
    ));

    try {
      final uri = Uri.parse("http://192.168.0.44:8000/download");
      final request = http.Request('POST', uri)
        ..headers['Content-Type'] = 'application/json'
        ..body = jsonEncode(preferences);

      final streamedResponse = await request.send();

      final lines = streamedResponse.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      await for (final line in lines) {
        if (line.startsWith('data: ')) {
          final jsonString = line.substring(6);

          try {
            final Map<String, dynamic> eventData = jsonDecode(jsonString);
            final message = eventData['message'] ?? '';
            add(LogAppended("$message\n"));
          } catch (_) {
            add(LogAppended("$line\n"));
          }
        }
      }

      emit(state.copyWith(
        isDownloading: false,
        logOutput: "${state.logOutput}[*] Download finished.\n",
      ));
    } catch (e) {
      emit(state.copyWith(
        isDownloading: false,
        logOutput: "${state.logOutput}[!] Exception: $e\n",
      ));
    }
  }

  Future<void> _onLogAppended(LogAppended event, Emitter<HomeState> emit) async {
    emit(state.copyWith(logOutput: "${state.logOutput}${event.message}"));
  }

  Future<void> _onClearLog(ClearLog event, Emitter<HomeState> emit) async {
    emit(state.copyWith(logOutput: ""));
  }
}

