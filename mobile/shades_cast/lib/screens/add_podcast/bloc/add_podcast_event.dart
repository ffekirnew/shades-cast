part of 'add_podcast_bloc.dart';

@immutable
abstract class AddPodcastEvent {}

class PodcastSubmitted extends AddPodcastEvent {
  dynamic createdPodcast;
  PodcastSubmitted({required this.createdPodcast});
}
