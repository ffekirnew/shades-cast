part of 'favorite_podcasts_bloc.dart';

@immutable
abstract class FavoritePodcastsState {}

class FavoritePodcastsInitial extends FavoritePodcastsState {}

class FavPodcastListerLoadingState extends FavoritePodcastsState {}

class FavPodcastLoadedState extends FavoritePodcastsState {
  final List<Podcast> podcasts;
  final List<int> favoritedPodcastId;

  FavPodcastLoadedState({
    required this.podcasts,
    required this.favoritedPodcastId,
  });
}
