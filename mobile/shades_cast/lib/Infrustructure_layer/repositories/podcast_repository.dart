import 'package:shades_cast/domain_layer/episode.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/Infrustructure_layer/database/podcast_database.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';

abstract class PodcastRepository {
  Future<List<dynamic>> getPodcasts();

  Future<Podcast> getPodcastById(String podcastId);

  Future<void> addPodcast(Podcast podcast);

  Future<void> deletePodcast(String podcastId);

  // Future<void> saveEpisodes(String podcastId, List<dynamic> episodes);

  Future<void> addEpisode(String podcastId, List<dynamic> episode);
  Future<void> deleteEpisode(String podcastId, List<dynamic> episode);
}

class PodcastRepositoryImpl implements PodcastRepository {
  final PodcastDatabase _database;
  final PodcastApiClient _apiClient;

  PodcastRepositoryImpl(this._database, this._apiClient);

  @override
  Future<List<dynamic>> getPodcasts() async {
    final localPodcasts = await _database.getPodcasts();

    if (localPodcasts.isNotEmpty) {
      return localPodcasts;
    } else {
      final remotePodcasts = await _apiClient.getPodcasts();
      await _database.savePodcasts(remotePodcasts);
      return remotePodcasts;
    }
  }

  @override
  Future<Podcast> getPodcastById(String podcastId) async {
    final localPodcast = await _database.getPodcastById(podcastId);

    if (localPodcast != null) {
      return localPodcast;
    } else {
      final remotePodcast = await _apiClient.getPodcastById(podcastId);
      await _database.savePodcast(remotePodcast);
      return remotePodcast;
    }
  }

  @override
  Future<void> addPodcast(Podcast podcast) async {
    await _apiClient.addPodcast(podcast);
    await _database.savePodcast(podcast);
  }

  @override
  Future<void> deletePodcast(String podcastId) async {
    await _apiClient.deletePodcast(podcastId);
    await _database.deletePodcast(podcastId);
  }

  @override
  Future<void> addEpisodes(String podcastId, List<dynamic> episodes) async {
    List<Episode> Episodes = [];
    for (Episode episode in episodes) {
      Episodes.add(Episode.fromMap(episode as Map<String, dynamic>));
    }
    await _database.saveEpisodes(podcastId, Episodes);
    // await _apiClient.saveEpisodes(episodes);
  }

  @override
  Future<void> addEpisode(String podcastId, dynamic episode) async {
    Episode saved_episode = Episode.fromMap(episode as Map<String, dynamic>);
    await _database.saveEpisode(podcastId, saved_episode);
    await _apiClient.addEpisode(podcastId, saved_episode);
  }

  @override
  Future<void> deleteEpisode(String podcastId, List episode) async {
    Episode deleted_episode = Episode.fromMap(episode as Map<String, dynamic>);
    await _database.deleteEpisode(podcastId, deleted_episode);
    await _apiClient.deleteEpisode(podcastId, deleted_episode);
  }
}

