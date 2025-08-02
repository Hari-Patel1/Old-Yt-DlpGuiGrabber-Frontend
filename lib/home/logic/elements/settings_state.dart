part of "settings_bloc.dart";

class SettingsState extends Equatable {
  final bool notificationsEnabled;
  final Directory? downloadDirectory;
  final bool isLoading;

  const SettingsState({
    this.notificationsEnabled = true,
    this.downloadDirectory,
    this.isLoading = true,
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    Directory? downloadDirectory,
    bool? isLoading,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      downloadDirectory: downloadDirectory ?? this.downloadDirectory,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [notificationsEnabled, downloadDirectory?.path, isLoading];
}
