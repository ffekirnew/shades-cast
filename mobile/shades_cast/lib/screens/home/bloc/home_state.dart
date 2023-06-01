part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {
  final funfactVisibility = true;

  final User currentUser;
  HomeInitial({required this.currentUser});
}

class PodcastListerLoadingState extends HomeState {
  final User currentUser;
  final funfactVisibility;
  PodcastListerLoadingState(
      {required this.currentUser, required this.funfactVisibility});
}

class PodcastSearchingState extends HomeState {
  final User currentUser;
  final funfactVisibility;
  PodcastSearchingState(
      {required this.currentUser, required this.funfactVisibility});
}

class FunFactLoadingState extends HomeState {
  final funfactVisibility = true;
}

class PodcastLoadedState extends HomeState {
  final List<Podcast> podcasts;
  final List<int> favoritedPodcastId;
  final Funfact funFact;
  final funfactVisibility;

  final User currentUser;

  PodcastLoadedState(
      {required this.podcasts,
      required this.favoritedPodcastId,
      required this.funFact,
      required this.currentUser,
      required this.funfactVisibility});
}

class PodcastsErrorState extends HomeState {
  final User currentUser;
  final funfactVisibility;

  PodcastsErrorState(
      {required this.currentUser, this.funfactVisibility = true});
}
