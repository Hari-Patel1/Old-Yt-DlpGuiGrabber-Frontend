part of 'auto_tag_bloc.dart';

abstract class AutoTagEvent extends Equatable {
  const AutoTagEvent();

  @override
  List<Object?> get props => [];
}


class LoadFiles extends AutoTagEvent {
  final List<SongModel> songs;

  const LoadFiles(this.songs);

  @override
  List<Object?> get props => [songs];
}


class FetchTagsForCurrentFile extends AutoTagEvent {}

class UpdateTagField extends AutoTagEvent {
  final String? title;
  final String? artist;
  final String? album;
  final Uint8List? albumArt;

  const UpdateTagField({this.title, this.artist, this.album, this.albumArt});

  @override
  List<Object?> get props => [title, artist, album, albumArt];
}

class SaveCurrentTag extends AutoTagEvent {}

class SkipCurrentFile extends AutoTagEvent {}

class CancelTagging extends AutoTagEvent {}
