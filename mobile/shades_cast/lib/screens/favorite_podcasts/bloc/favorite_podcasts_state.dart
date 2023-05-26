part of 'favorite_podcasts_bloc.dart';

@immutable
abstract class FavoritePodcastsState {}

class FavoritePodcastsInitial extends FavoritePodcastsState {}

class PodcastListerLoadingState extends FavoritePodcastsState {}

class PodcastLoadedState extends FavoritePodcastsState {
  final List<Podcast> podcasts;
  final List<int> favoritedPodcastId;

  PodcastLoadedState({
    required this.podcasts,
    required this.favoritedPodcastId,
  });
}
