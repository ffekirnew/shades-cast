part of 'podcast_details_and_player_bloc.dart';

@immutable
abstract class PodcastDetailsAndPlayerEvent {}

class PodcastDetailPageOpened extends PodcastDetailsAndPlayerEvent {
  final int podcastId;
  PodcastDetailPageOpened({required this.podcastId});
}

class EpisodeItemClicked extends PodcastDetailsAndPlayerEvent {
  final int selectedIndex;
  EpisodeItemClicked({required this.selectedIndex});
}

class SkipToNextButtonClicked extends PodcastDetailsAndPlayerEvent {
  final int selectedIndex;
  SkipToNextButtonClicked({required this.selectedIndex});
}

class SkipToPreviousButtonClicked extends PodcastDetailsAndPlayerEvent {
  final int selectedIndex;
  SkipToPreviousButtonClicked({required this.selectedIndex});
}
