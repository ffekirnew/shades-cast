part of 'podcast_details_and_player_bloc.dart';

@immutable
abstract class PodcastDetailsAndPlayerState {}

class PodcastDetailsAndPlayerInitial extends PodcastDetailsAndPlayerState {
  final List<EpisodeItem> episodes;
  final currentPlayingEpisode;
  final audioUrls;
  PodcastDetailsAndPlayerInitial(
      {required this.episodes,
      required this.currentPlayingEpisode,
      this.audioUrls});
}

class PodcastLoadingState extends PodcastDetailsAndPlayerState {}

class PodcastDetailEpisodes extends PodcastDetailsAndPlayerState {
  final List<Episode> episodes;
  final currentPlayingEpisode;
  final Podcast podcast;

  PodcastDetailEpisodes(
      {required this.episodes,
      required this.currentPlayingEpisode,
      required this.podcast});
}

class PodcastDetailsAndPlayerErrorState extends PodcastDetailsAndPlayerState {}
