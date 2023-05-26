part of 'my_podcasts_bloc.dart';

@immutable
abstract class MyPodcastsState {}

class MyPodcastsInitial extends MyPodcastsState {}

class PodcastListerLoadingState extends MyPodcastsState {}

class PodcastLoadedState extends MyPodcastsState {
  final List<Podcast> podcasts;
  final List<int> favoritedPodcastId;

  PodcastLoadedState({
    required this.podcasts,
    required this.favoritedPodcastId,
  });
}
