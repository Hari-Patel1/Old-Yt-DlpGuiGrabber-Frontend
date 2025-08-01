import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchUrlFromClipboard>(_onFetchUrlFromClipboard);
    on<SetUrl>(_onSetUrl);
    on<UpdatePreferences>(_onUpdatePreferences);
    on<DownloadSubmitted>(_onDownloadSubmitted);
  }

  Future<void> _onFetchUrlFromClipboard(
      FetchUrlFromClipboard event,
      Emitter<HomeState> emit,
      ) async {
    final data = await Clipboard.getData('text/plain');
    emit(state.copyWith(url: data?.text ?? ''));
  }

  Future<void> _onSetUrl(
      SetUrl event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(url: event.url));
  }

  Future<void> _onUpdatePreferences(
      UpdatePreferences event,
      Emitter<HomeState> emit,
      ) async {

  }

  Future<void> _onDownloadSubmitted(
      DownloadSubmitted event,
      Emitter<HomeState> emit,
      ) async {
    print(event.url);
  }
}
