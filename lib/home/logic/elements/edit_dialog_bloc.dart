import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_dialog_event.dart';
part 'edit_dialog_state.dart';

class EditDialogBloc extends Bloc<EditDialogEvent, EditDialogState> {
  EditDialogBloc() : super(const EditDialogState()) {
    on<LoadPreferences>(_onLoadPreferences);
    on<UpdateExtension>(_onUpdateExtension);
    on<UpdateAudioOnly>(_onUpdateAudioOnly);
    on<UpdateAudioQuality>(_onUpdateAudioQuality);
    on<UpdateVideoQuality>(_onUpdateVideoQuality);
    on<UpdateEmbedThumbnail>(_onUpdateEmbedThumbnail);
    on<UpdateDownloadAlbumArt>(_onUpdateDownloadAlbumArt);
    on<UpdateAddMetadata>(_onUpdateAddMetadata);
    on<SavePreferences>(_onSavePreferences);
  }

  Future<void> _onLoadPreferences(
      LoadPreferences event,
      Emitter<EditDialogState> emit,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    emit(EditDialogState(
      selectedExtension: prefs.getString('extension') ?? 'mp4',
      audioOnly: prefs.getBool('audioOnly') ?? false,
      selectedAudioQuality: prefs.getString('audioQuality') ?? '320k',
      selectedVideoQuality: prefs.getString('videoQuality') ?? '1080p',
      embedThumbnail: prefs.getBool('embedThumbnail') ?? true,
      downloadAlbumArt: prefs.getBool('downloadAlbumArt') ?? true,
      addMetadata: prefs.getBool('addMetadata') ?? true,
    ));
  }

  void _onUpdateExtension(UpdateExtension event, Emitter<EditDialogState> emit) {
    emit(state.copyWith(selectedExtension: event.extension));
  }

  void _onUpdateAudioOnly(UpdateAudioOnly event, Emitter<EditDialogState> emit) {
    emit(state.copyWith(audioOnly: event.audioOnly));
  }

  void _onUpdateAudioQuality(UpdateAudioQuality event, Emitter<EditDialogState> emit) {
    emit(state.copyWith(selectedAudioQuality: event.audioQuality));
  }

  void _onUpdateVideoQuality(UpdateVideoQuality event, Emitter<EditDialogState> emit) {
    emit(state.copyWith(selectedVideoQuality: event.videoQuality));
  }

  void _onUpdateEmbedThumbnail(UpdateEmbedThumbnail event, Emitter<EditDialogState> emit) {
    emit(state.copyWith(embedThumbnail: event.embedThumbnail));
  }

  void _onUpdateDownloadAlbumArt(UpdateDownloadAlbumArt event, Emitter<EditDialogState> emit) {
    emit(state.copyWith(downloadAlbumArt: event.downloadAlbumArt));
  }

  void _onUpdateAddMetadata(UpdateAddMetadata event, Emitter<EditDialogState> emit) {
    emit(state.copyWith(addMetadata: event.addMetadata));
  }

  Future<void> _onSavePreferences(SavePreferences event, Emitter<EditDialogState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('extension', state.selectedExtension);
    await prefs.setBool('audioOnly', state.audioOnly);
    await prefs.setString('audioQuality', state.selectedAudioQuality);
    await prefs.setString('videoQuality', state.selectedVideoQuality);
    await prefs.setBool('embedThumbnail', state.embedThumbnail);
    await prefs.setBool('downloadAlbumArt', state.downloadAlbumArt);
    await prefs.setBool('addMetadata', state.addMetadata);
  }
}
