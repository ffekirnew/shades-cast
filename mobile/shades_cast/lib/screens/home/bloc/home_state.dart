part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class PodcastListerLoadingState extends HomeState {}

class PodcastSearchingState extends HomeState {}

class FunFactLoadingState extends HomeState {}

class PodcastLoadedState extends HomeState {
  final List<Podcast> podcasts;
  final List<int> favoritedPodcastId;
  final Funfact funFact;

  PodcastLoadedState(
      {required this.podcasts,
      required this.favoritedPodcastId,
      required this.funFact});
}

// class PodcastFavoritedState extends HomeState {
//   final int podcastId;
//   PodcastFavoritedState({required this.podcastId});
// }
