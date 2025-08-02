part of "settings_bloc.dart";

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ToggleNotifications extends SettingsEvent {
  final bool enabled;
  const ToggleNotifications(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class SetDownloadDirectory extends SettingsEvent {
  final Directory directory;
  const SetDownloadDirectory(this.directory);

  @override
  List<Object?> get props => [directory];
}
