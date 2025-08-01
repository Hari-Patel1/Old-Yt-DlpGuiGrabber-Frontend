part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String? url;

  const HomeState({this.url});

  HomeState copyWith({String? url}) {
    return HomeState(url: url ?? this.url);
  }

  @override
  List<Object?> get props => [url];
}
