part of "edit_dialog_bloc.dart";

class EditDialogState extends Equatable {
  final String selectedExtension;
  final bool audioOnly;
  final String selectedAudioQuality;
  final String selectedVideoQuality;
  final bool embedThumbnail;
  final bool downloadAlbumArt;
  final bool addMetadata;

  const EditDialogState({
    this.selectedExtension = "mp4",
    this.audioOnly = false,
    this.selectedAudioQuality = "320k",
    this.selectedVideoQuality = "1080p",
    this.embedThumbnail = true,
    this.downloadAlbumArt = true,
    this.addMetadata = true,
  });

  EditDialogState copyWith({
    String? selectedExtension,
    bool? audioOnly,
    String? selectedAudioQuality,
    String? selectedVideoQuality,
    bool? embedThumbnail,
    bool? downloadAlbumArt,
    bool? addMetadata,
  }) {
    return EditDialogState(
      selectedExtension: selectedExtension ?? this.selectedExtension,
      audioOnly: audioOnly ?? this.audioOnly,
      selectedAudioQuality: selectedAudioQuality ?? this.selectedAudioQuality,
      selectedVideoQuality: selectedVideoQuality ?? this.selectedVideoQuality,
      embedThumbnail: embedThumbnail ?? this.embedThumbnail,
      downloadAlbumArt: downloadAlbumArt ?? this.downloadAlbumArt,
      addMetadata: addMetadata ?? this.addMetadata,
    );
  }

  @override
  List<Object> get props => [
    selectedExtension,
    audioOnly,
    selectedAudioQuality,
    selectedVideoQuality,
    embedThumbnail,
    downloadAlbumArt,
    addMetadata,
  ];
}
