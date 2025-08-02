import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter/services.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../methods/yt_dlp_service.dart";

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchUrlFromClipboard>(_onFetchUrlFromClipboard);
    on<SetUrl>(_onSetUrl);
    on<UpdatePreferences>(_onUpdatePreferences);
    on<DownloadSubmitted>(_onDownloadSubmitted);
  }

  Future<void> _onFetchUrlFromClipboard(
    FetchUrlFromClipboard event,
    Emitter<HomeState> emit,
  ) async {
    final data = await Clipboard.getData("text/plain");
    emit(state.copyWith(url: data?.text ?? ""));
  }

  Future<void> _onSetUrl(SetUrl event, Emitter<HomeState> emit) async {
    emit(state.copyWith(url: event.url));
  }

  Future<void> _onUpdatePreferences(
    UpdatePreferences event,
    Emitter<HomeState> emit,
  ) async {}

  Future<void> _onDownloadSubmitted(
    DownloadSubmitted event,
    Emitter<HomeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    // Collect preferences
    final preferences = {
      "url": event.url,
      "extension": prefs.getString("extension") ?? "mp4",
      "audioOnly": prefs.getBool("audioOnly") ?? false,
      "audioQuality": prefs.getString("audioQuality") ?? "320k",
      "videoQuality": prefs.getString("videoQuality") ?? "1080p",
      "embedThumbnail": prefs.getBool("embedThumbnail") ?? true,
      "downloadAlbumArt": prefs.getBool("downloadAlbumArt") ?? true,
      "addMetadata": prefs.getBool("addMetadata") ?? true,
      "downloadDirectory": prefs.getString("download_directory")
    };

    try {
      final response = await prefsPost(preferences);
      print("Backend responded: $response");
    } catch (e) {
      print("Error sending preferences: $e");
    }
  }
}
