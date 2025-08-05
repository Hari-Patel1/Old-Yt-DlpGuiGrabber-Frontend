import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'auto_tag_event.dart';
part 'auto_tag_state.dart';

class AutoTagBloc extends Bloc<AutoTagEvent, AutoTagState> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  AutoTagBloc() : super(const AutoTagState()) {
    on<LoadFiles>(_onLoadFiles);
    on<FetchTagsForCurrentFile>(_onFetchTags);
    on<UpdateTagField>(_onUpdateTagField);
    on<SaveCurrentTag>(_onSaveTag);
    on<SkipCurrentFile>(_onSkip);
    on<CancelTagging>(_onCancel);
  }

  Future<void> _onLoadFiles(LoadFiles event, Emitter<AutoTagState> emit) async {
    if (event.songs.isEmpty) return;
    emit(state.copyWith(filesToTag: event.songs, currentIndex: 0));
    add(FetchTagsForCurrentFile());
  }

  Future<void> _onFetchTags(FetchTagsForCurrentFile event, Emitter<AutoTagState> emit) async {
    emit(state.copyWith(isLoading: true, hasError: false));

    try {
      final currentSong = state.filesToTag[state.currentIndex];

      // Fetch album art bytes (optional, can be null or empty)
      Uint8List albumArtBytes = Uint8List(0);
      try {
        final art = await _audioQuery.queryArtwork(currentSong.id, ArtworkType.AUDIO);
        if (art != null) albumArtBytes = art;
      } catch (_) {
        // Ignore if artwork can't be loaded
      }

      final title = currentSong.title.isNotEmpty ? currentSong.title : "Unknown Title";
      final artist = currentSong.artist ?? "Unknown Artist";
      final album = currentSong.album ?? "Unknown Album";

      emit(state.copyWith(
        isLoading: false,
        suggestedTitle: title,
        suggestedArtist: artist,
        suggestedAlbum: album,
        suggestedAlbumArt: albumArtBytes,
        title: title,
        artist: artist,
        album: album,
        albumArt: albumArtBytes,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasError: true, errorMessage: e.toString()));
    }
  }

  void _onUpdateTagField(UpdateTagField event, Emitter<AutoTagState> emit) {
    emit(state.copyWith(
      title: event.title ?? state.title,
      artist: event.artist ?? state.artist,
      album: event.album ?? state.album,
      albumArt: event.albumArt ?? state.albumArt,
    ));
  }

  Future<void> _onSaveTag(SaveCurrentTag event, Emitter<AutoTagState> emit) async {
    // TODO: Implement writing tags to file - you may need a native plugin or backend for that

    final nextIndex = state.currentIndex + 1;
    if (nextIndex >= state.filesToTag.length) {
      emit(state.copyWith(currentIndex: nextIndex));
      return;
    }

    emit(state.copyWith(currentIndex: nextIndex));
    add(FetchTagsForCurrentFile());
  }

  void _onSkip(SkipCurrentFile event, Emitter<AutoTagState> emit) {
    final nextIndex = state.currentIndex + 1;
    if (nextIndex >= state.filesToTag.length) return;

    emit(state.copyWith(currentIndex: nextIndex));
    add(FetchTagsForCurrentFile());
  }

  void _onCancel(CancelTagging event, Emitter<AutoTagState> emit) {
    emit(const AutoTagState());
  }
}
