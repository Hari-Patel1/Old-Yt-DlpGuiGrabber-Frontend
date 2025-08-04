part of "home_bloc.dart";

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchUrlFromClipboard extends HomeEvent {}

class SetUrl extends HomeEvent {
  final String url;
  const SetUrl(this.url);

  @override
  List<Object?> get props => [url];
}

class UpdatePreferences extends HomeEvent {
  const UpdatePreferences(
      this.selectedExtension,
      this.audioOnly,
      this.selectedAudioQuality,
      this.selectedVideoQuality,
      this.embedThumbnail,
      this.downloadAlbumArt,
      this.addMetadata,
      );

  final String selectedExtension;
  final bool audioOnly;
  final String selectedAudioQuality;
  final String selectedVideoQuality;
  final bool embedThumbnail;
  final bool downloadAlbumArt;
  final bool addMetadata;

  @override
  List<Object?> get props => [
    selectedExtension,
    audioOnly,
    selectedAudioQuality,
    selectedVideoQuality,
    embedThumbnail,
    downloadAlbumArt,
    addMetadata,
  ];
}

class DownloadSubmitted extends HomeEvent {
  const DownloadSubmitted(this.url);
  final String url;

  @override
  List<Object?> get props => [url];
}

class LogAppended extends HomeEvent {
  final String message;
  const LogAppended(this.message);

  @override
  List<Object?> get props => [message];
}

class ClearLog extends HomeEvent {
  const ClearLog();
}