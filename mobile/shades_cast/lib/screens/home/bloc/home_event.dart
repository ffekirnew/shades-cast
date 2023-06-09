part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class PodcastClicked extends HomeEvent {
  final int podcastId;
  PodcastClicked({required this.podcastId});
}

class PodcastSearched extends HomeEvent {
  final String searchTerm;
  PodcastSearched({required this.searchTerm});
}

class PodcasFavorited extends HomeEvent {
  final int podcastId;
  PodcasFavorited({required this.podcastId});
}

class PodcasUnFavorited extends HomeEvent {
  final int podcastId;
  PodcasUnFavorited({required this.podcastId});
}

class GetPodcasts extends HomeEvent {}

class FunfactWindowClosed extends HomeEvent {
  final context;
  FunfactWindowClosed({required this.context});
}

class DeleteUserAccount extends HomeEvent {
  final int userId;
  final context;
  DeleteUserAccount({required this.userId, required this.context});
}
