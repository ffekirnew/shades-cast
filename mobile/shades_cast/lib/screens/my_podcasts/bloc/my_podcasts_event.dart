part of 'my_podcasts_bloc.dart';

@immutable
abstract class MyPodcastsEvent {}

class GetMyPodcasts extends MyPodcastsEvent {}

class MyPodcastFavorited extends MyPodcastsEvent {
  final podcastId;
  MyPodcastFavorited({this.podcastId});
}
