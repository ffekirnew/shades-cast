part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {
  final User currentUser;
  HomeInitial({required this.currentUser});
}

class PodcastListerLoadingState extends HomeState {
  final User currentUser;
  PodcastListerLoadingState({required this.currentUser});
}

class PodcastSearchingState extends HomeState {
  final User currentUser;

  PodcastSearchingState({required this.currentUser});
}

class FunFactLoadingState extends HomeState {}

class PodcastLoadedState extends HomeState {
  final List<Podcast> podcasts;
  final List<int> favoritedPodcastId;
  final Funfact funFact;
  final User currentUser;

  PodcastLoadedState(
      {required this.podcasts,
      required this.favoritedPodcastId,
      required this.funFact,
      required this.currentUser});
}

class PodcastsErrorState extends HomeState {
  final User currentUser;
  PodcastsErrorState({required this.currentUser});
}

// class PodcastFavoritedState extends HomeState {
//   final int podcastId;
//   PodcastFavoritedState({required this.podcastId});
// }
