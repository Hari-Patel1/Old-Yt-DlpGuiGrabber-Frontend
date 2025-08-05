part of 'auto_tag_bloc.dart';

class AutoTagState extends Equatable {
  final List<SongModel> filesToTag; // List of songs to tag
  final int currentIndex; // Which file we're currently editing

  // Suggested tags
  final String? suggestedTitle;
  final String? suggestedArtist;
  final String? suggestedAlbum;
  final Uint8List? suggestedAlbumArt; // Could be base64 or bytes

  // User-edited tags (defaults to suggestions)
  final String title;
  final String artist;
  final String album;
  final Uint8List? albumArt;

  // Status flags
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  const AutoTagState({
    this.filesToTag = const [],
    this.currentIndex = 0,
    this.suggestedTitle,
    this.suggestedArtist,
    this.suggestedAlbum,
    this.suggestedAlbumArt,
    this.title = '',
    this.artist = '',
    this.album = '',
    this.albumArt,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  AutoTagState copyWith({
    List<SongModel>? filesToTag,
    int? currentIndex,
    String? suggestedTitle,
    String? suggestedArtist,
    String? suggestedAlbum,
    Uint8List? suggestedAlbumArt,
    String? title,
    String? artist,
    String? album,
    Uint8List? albumArt,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return AutoTagState(
      filesToTag: filesToTag ?? this.filesToTag,
      currentIndex: currentIndex ?? this.currentIndex,
      suggestedTitle: suggestedTitle ?? this.suggestedTitle,
      suggestedArtist: suggestedArtist ?? this.suggestedArtist,
      suggestedAlbum: suggestedAlbum ?? this.suggestedAlbum,
      suggestedAlbumArt: suggestedAlbumArt ?? this.suggestedAlbumArt,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      albumArt: albumArt ?? this.albumArt,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    filesToTag,
    currentIndex,
    suggestedTitle,
    suggestedArtist,
    suggestedAlbum,
    suggestedAlbumArt,
    title,
    artist,
    album,
    albumArt,
    isLoading,
    hasError,
    errorMessage,
  ];
}
