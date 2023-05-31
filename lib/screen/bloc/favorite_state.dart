part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState extends Equatable {
  FavoriteState([List props = const []]) : super();
  // const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {
  @override
  List<Object> get props => [];
}

class Loading extends FavoriteState {}

class Loaded extends FavoriteState {
  final List<Podcast> podcasts;
  Loaded(this.podcasts) : super([podcasts]);
}

class Navigation extends FavoriteState {
  @override
  List<Object> get props => [];
}

class Error extends FavoriteState {
  final String errorMessage;

  Error(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class Empty extends FavoriteState {
  @override
  List<Object> get props => [];
}
