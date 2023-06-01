part of 'edit_podcast_bloc.dart';

@immutable
abstract class EditPodcastEvent {}

class EditPodcastSubmitted extends EditPodcastEvent {
  dynamic modifiedPodcast;
  int podcastId;
  EditPodcastSubmitted(
      {required this.modifiedPodcast, required this.podcastId});
}
