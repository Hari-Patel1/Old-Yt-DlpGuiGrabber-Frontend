import "dart:io";
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:shared_preferences/shared_preferences.dart";

part "settings_event.dart";
part "settings_state.dart";

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleNotifications>(_onToggleNotifications);
    on<SetDownloadDirectory>(_onSetDownloadDirectory);
  }

  Future<void> _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool("notifications_enabled") ?? true;
    final path = prefs.getString("download_directory");
    final dir = (path != null && Directory(path).existsSync()) ? Directory(path) : null;

    emit(state.copyWith(
      notificationsEnabled: enabled,
      downloadDirectory: dir,
      isLoading: false,
    ));
  }

  Future<void> _onToggleNotifications(
      ToggleNotifications event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notifications_enabled", event.enabled);
    emit(state.copyWith(notificationsEnabled: event.enabled));
  }

  Future<void> _onSetDownloadDirectory(
      SetDownloadDirectory event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("download_directory", event.directory.path);
    emit(state.copyWith(downloadDirectory: event.directory));
  }
}
