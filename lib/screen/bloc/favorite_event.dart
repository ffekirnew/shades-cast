part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends FavoriteEvent {
  @override
  List<Object> get props => [];
}

class SwipeOutPodcast extends FavoriteEvent {
  final int podcastIndex;

  SwipeOutPodcast(this.podcastIndex);

  @override
  List<Object> get props => [podcastIndex];
}

class TapToListen extends FavoriteEvent {
  final Podcast podcast;

  TapToListen(this.podcast);

  @override
  List<Object> get props => [podcast];
}
