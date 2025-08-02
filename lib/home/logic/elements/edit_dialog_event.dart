part of "edit_dialog_bloc.dart";

abstract class EditDialogEvent extends Equatable {
  const EditDialogEvent();

  @override
  List<Object?> get props => [];
}

class LoadPreferences extends EditDialogEvent {}

class UpdateExtension extends EditDialogEvent {
  final String extension;
  const UpdateExtension(this.extension);
  @override
  List<Object?> get props => [extension];
}

class UpdateAudioOnly extends EditDialogEvent {
  final bool audioOnly;
  const UpdateAudioOnly(this.audioOnly);
  @override
  List<Object?> get props => [audioOnly];
}

class UpdateAudioQuality extends EditDialogEvent {
  final String audioQuality;
  const UpdateAudioQuality(this.audioQuality);
  @override
  List<Object?> get props => [audioQuality];
}

class UpdateVideoQuality extends EditDialogEvent {
  final String videoQuality;
  const UpdateVideoQuality(this.videoQuality);
  @override
  List<Object?> get props => [videoQuality];
}

class UpdateEmbedThumbnail extends EditDialogEvent {
  final bool embedThumbnail;
  const UpdateEmbedThumbnail(this.embedThumbnail);
  @override
  List<Object?> get props => [embedThumbnail];
}

class UpdateDownloadAlbumArt extends EditDialogEvent {
  final bool downloadAlbumArt;
  const UpdateDownloadAlbumArt(this.downloadAlbumArt);
  @override
  List<Object?> get props => [downloadAlbumArt];
}

class UpdateAddMetadata extends EditDialogEvent {
  final bool addMetadata;
  const UpdateAddMetadata(this.addMetadata);
  @override
  List<Object?> get props => [addMetadata];
}

class SavePreferences extends EditDialogEvent {}
