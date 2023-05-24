part of 'podcast_details_and_player_bloc.dart';

@immutable
abstract class PodcastDetailsAndPlayerEvent {}

class EpisodeItemClicked extends PodcastDetailsAndPlayerEvent {
  final int selectedIndex;
  final int podcastId;
  EpisodeItemClicked({required this.selectedIndex, required this.podcastId});
}

class SkipToNextButtonClicked extends PodcastDetailsAndPlayerEvent {
  final int selectedIndex;
  SkipToNextButtonClicked({required this.selectedIndex});
}

class SkipToPreviousButtonClicked extends PodcastDetailsAndPlayerEvent {
  final int selectedIndex;
  SkipToPreviousButtonClicked({required this.selectedIndex});
}
