part of 'favorite_podcasts_bloc.dart';

@immutable
abstract class FavoritePodcastsEvent {}

class GetFavPodcasts extends FavoritePodcastsEvent {}

class FavPodcastFavorited extends FavoritePodcastsEvent {
  final podcastId;
  FavPodcastFavorited({this.podcastId});
}
