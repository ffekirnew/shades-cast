import 'package:shades_cast/domain_layer/episode.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';

abstract class PodcastRepository {
  Future<List<Podcast>> getPodcasts();

  Future<Podcast> getPodcastById(String podcastId);

  Future<List<Podcast>> getMyPodcasts();

  Future<void> addPodcast(Podcast podcast);

  Future<void> deletePodcast(String podcastId);

  // Future<void> saveEpisodes(String podcastId, List<dynamic> episodes);
  Future<List<Episode>> getEpisodes(String podcastId);

  Future<void> addEpisode(String podcastId, List<dynamic> episode);
  Future<void> deleteEpisode(String podcastId, List<dynamic> episode);

  Future<List<Podcast>> favoritePodcasts();
}

class PodcastRepositoryImpl implements PodcastRepository {
  final PodcastDatabase _database;
  final PodcastApiClient _apiClient;

  PodcastRepositoryImpl(this._database, this._apiClient);
////////////////////////////////////////////////
  ///
  ///
  ///
  @override
  Future<List<Podcast>> getPodcasts() async {
    final localPodcasts = await _database.getPodcasts();

    if (localPodcasts.isNotEmpty) {
      return localPodcasts;
    } else {
      List<dynamic> remotePodcasts = await _apiClient.getPodcasts();
      List<Podcast> podcasts = List.generate(remotePodcasts.length, (index) {
        return Podcast.fromMap(remotePodcasts[index]);
      });
      // await _database.savePodcasts(remotePodcasts);
      return podcasts;
    }
  }
  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///

  @override
  Future<Podcast> getPodcastById(String podcastId) async {
    final localPodcast = await _database.getPodcastById(podcastId);

    if (localPodcast != null) {
      return localPodcast;
    } else {
      final remotePodcast = await _apiClient.getPodcastById(podcastId);

      Podcast podcast = Podcast.fromMap(remotePodcast);
      // await _database.savePodcast(remotePodcast);
      return podcast;
    }
  }
  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///

  @override
  Future<void> addPodcast(Podcast podcast) async {
    await _apiClient.addPodcast(podcast);
    await _database.savePodcast(podcast);
  }
  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///

  @override
  Future<void> deletePodcast(String podcastId) async {
    await _apiClient.deletePodcast(podcastId);
    await _database.deletePodcast(podcastId);
  }

////////////////////////////////////////////////
  ///
  ///
  ///
  @override
  Future<void> addEpisodes(String podcastId, List<dynamic> episodes) async {
    List<Episode> Episodes = [];
    for (Episode episode in episodes) {
      Episodes.add(Episode.fromMap(episode as Map<String, dynamic>));
    }
    await _database.saveEpisodes(Episodes);
    // await _apiClient.saveEpisodes(episodes);
  }

/////////////////////////////// //////////////////////////////////
  ///
  ///
  @override
  Future<void> addEpisode(String podcastId, dynamic episode) async {
    Episode saved_episode = Episode.fromMap(episode as Map<String, dynamic>);
    await _database.saveEpisode(podcastId, saved_episode);
    await _apiClient.addEpisode(podcastId, saved_episode);
  }

  ////////////////////////////////////////////////
  ///
  ///

  @override
  Future<void> deleteEpisode(String podcastId, List episode) async {
    Episode deleted_episode = Episode.fromMap(episode as Map<String, dynamic>);
    await _database.deleteEpisode(podcastId, deleted_episode);
    await _apiClient.deleteEpisode(podcastId, deleted_episode);
  }

  ////////////////////////////////////
  ///
  ///
  ///

  @override
  Future<List<Episode>> getEpisodes(String podcastId) async {
    final localEpisodes = await _database.getEpisodes(podcastId);
    print("get episodes repo...");

    if (localEpisodes.length > 0) {
      print(localEpisodes);
      return localEpisodes;
    } else {
      print("get episodes repo");
      final remoteEpisodes = await _apiClient.getEpisodes(podcastId);
      List<Episode> episodes = List.generate(remoteEpisodes.length, (index) {
        return Episode.fromMap(remoteEpisodes[index]);
      });
      // await _database.saveEpisodes(episodes);
      if (episodes.length > 0) {
        Episode newEpisode = Episode(
            id: 2,
            podcastId: '1',
            title: 'episode 2',
            description: 'some other description',
            audioUrl:
                'https://fikernewapi.pythonanywhere.com/media/the-new-sho/2023/05/11/48a3737e-1076-4fab-9652-5fbb2af545d0.mp3',
            publishedDate: '',
            durationInSeconds: 20);
        episodes.add(newEpisode);
      }
      print(episodes);
      return episodes;
    }
  }


  @override
  Future<List<Podcast>> favoritePodcasts() async {
    final favourites = await _apiClient.favoritePodcasts();
    List<Podcast> favs = List.generate(favourites.length, (index) {
      return Podcast.fromMap(favourites[index]);
    });
    return favs;

////////////////////////////////////////////////
  ///
  ///
  ///
  @override
  Future<List<Podcast>> getMyPodcasts() async {
    // final localPodcasts = await _database.getPodcasts();

    // if (localPodcasts.isNotEmpty) {
    //   return localPodcasts;
    // } else {
    List<dynamic> remotePodcasts = await _apiClient.getMyPodcasts();
    List<Podcast> podcasts = List.generate(remotePodcasts.length, (index) {
      return Podcast.fromMap(remotePodcasts[index]);
    });
    // await _database.savePodcasts(remotePodcasts);
    return podcasts;
    // }

  }
}
