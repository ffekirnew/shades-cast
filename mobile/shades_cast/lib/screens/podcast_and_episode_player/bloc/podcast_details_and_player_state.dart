part of 'podcast_details_and_player_bloc.dart';

@immutable
abstract class PodcastDetailsAndPlayerState {
  bool isFromMyPodcasts = false;
}

class PodcastDetailsAndPlayerInitial extends PodcastDetailsAndPlayerState {
  final List<EpisodeItem> episodes;
  final currentPlayingEpisode;
  final audioUrls;
  final bool isFromMyPodcasts = false;
  PodcastDetailsAndPlayerInitial(
      {required this.episodes,
      required this.currentPlayingEpisode,
      this.audioUrls});
}

class PodcastLoadingState extends PodcastDetailsAndPlayerState {
  final bool isFromMyPodcasts = false;
}

class PodcastDetailEpisodes extends PodcastDetailsAndPlayerState {
  final List<Episode> episodes;
  final currentPlayingEpisode;
  final Podcast podcast;
  final bool isFromMyPodcasts;

  PodcastDetailEpisodes(
      {required this.episodes,
      required this.currentPlayingEpisode,
      required this.podcast,
      required this.isFromMyPodcasts});
}

class PodcastDetailsAndPlayerErrorState extends PodcastDetailsAndPlayerState {
  final bool isFromMyPodcasts = false;
}
