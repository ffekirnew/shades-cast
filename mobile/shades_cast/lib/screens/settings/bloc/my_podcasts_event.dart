part of 'my_podcasts_bloc.dart';

@immutable
abstract class MyPodcastsEvent {}

class PodcastSubmitted extends MyPodcastsEvent {
  dynamic createdPodcast;
  PodcastSubmitted({required this.createdPodcast});
}
