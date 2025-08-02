part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String url;
  final bool isDownloading;
  final String logOutput;

  const HomeState({
    this.url = "",
    this.isDownloading = false,
    this.logOutput = "",
  });

  HomeState copyWith({
    String? url,
    bool? isDownloading,
    String? logOutput,
  }) {
    return HomeState(
      url: url ?? this.url,
      isDownloading: isDownloading ?? this.isDownloading,
      logOutput: logOutput ?? this.logOutput,
    );
  }

  @override
  List<Object?> get props => [url, isDownloading, logOutput];
}