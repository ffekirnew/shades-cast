import 'dart:convert';
import 'dart:math';

import 'package:shades_cast/domain_layer/episode.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/domain_layer/user.dart';

import 'package:shades_cast/repository/database/podcast_database.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';

import 'package:shades_cast/Infrustructure_layer/api_clients/constants.dart';

abstract class PodcastRepository {
  Future<List<Podcast>> getPodcasts();

  Future<Podcast> getPodcastById(String podcastId);

  Future<List<Podcast>> searchPodcasts(String query);

  Future<List<Podcast>> getMyPodcasts();

  Future<void> addPodcast(dynamic podcast);

  Future<void> deletePodcast(String podcastId);

  // Future<void> saveEpisodes(String podcastId, List<dynamic> episodes);
  Future<List<Episode>> getEpisodes(String podcastId);

  Future<void> addEpisode(dynamic episode);
  Future<void> deleteEpisode(String episodeId);

  Future<List<Podcast>> favoritePodcasts();

  Future<List<Podcast>> myPodcasts();
  Future<void> addToFavorite(String podcastId);
  Future<void> deleteFromFavorite(String podcastId);
  Future<void> updatePodcast(dynamic podcast, String podcastId);
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
    }

    List<dynamic> remotePodcasts = await _apiClient.getPodcasts();
    List<Podcast> podcasts = List.generate(remotePodcasts.length, (index) {
      return Podcast.fromMap(remotePodcasts[index]);
    });
    print(podcasts);

    // await _database.savePodcasts(remotePodcasts);
    return podcasts;
  }
  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///

  @override
  Future<Podcast> getPodcastById(String podcastId) async {
    // final localPodcast = await _database.getPodcastById(podcastId);

    // if (localPodcast != null) {
    //   return localPodcast;
    // } else {
    try {
      final remotePodcast = await _apiClient.getPodcastById(podcastId);

      Podcast podcast = Podcast.fromMap(remotePodcast);
      // await _database.savePodcast(remotePodcast);
      return podcast;
    } catch (e) {
      print(e);
      throw ("Couldn't get podcast in repository");
    }
    // }
  }
  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///

  @override
  Future<void> addPodcast(dynamic podcast) async {
    final res = await _apiClient.addPodcast(podcast);
    print('printing');
    print(podcast);
    if (res == null) {
      throw Exception("error getting the created podcast");
    }
  }

  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  Future<void> addToFavorite(String podcastId) async {
    try {
      await _apiClient.addToFavorite(podcastId);
      // await _database.savePodcast(podcast)
    } catch (e) {
      print(e);
      throw ("Couldn't add To Favorites in Repository");
    }
  }

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
  Future<void> addEpisode(dynamic episode) async {
    print('got here safeeee');
    Episode saved_episode = Episode.fromMap(episode as Map<String, dynamic>);
    print(saved_episode);
    print('heere tooo');
    // await _database.saveEpisode(saved_episode);
    await _apiClient.addEpisode(episode);
  }

  ////////////////////////////////////////////////
  ///
  ///

  @override
  Future<void> deleteEpisode(String episodeId) async {
    await _database.deleteEpisode(episodeId);
    await _apiClient.deleteEpisode(episodeId);
  }

  ////////////////////////////////////
  ///
  ///
  ///

  @override
  Future<List<Episode>> getEpisodes(String podcastId) async {
    // final localEpisodes = await _database.getEpisodes(podcastId);

    // if (localEpisodes.length > 0) {
    //   return localEpisodes;
    // }
    // else {
    try {
      final remoteEpisodes = await _apiClient.getEpisodes(podcastId);
      print(remoteEpisodes);
      List<Episode> episodes = [];

      for (final episode in remoteEpisodes) {
        final newEpisode = Episode.fromMap(episode);
        episodes.add(newEpisode);
      }
      print(episodes);
      // await _database.saveEpisodes(episodes);

      return episodes;
    } catch (e) {
      print(e);
      throw ("Can not get podcast or episodes in repository");
    }
    // }
  }

  @override
  Future<List<Podcast>> favoritePodcasts() async {
    // final localFavorites = await _database.getFavorites();

    // if (localFavorites != null) {
    //   return localFavorites;
    // } else {
    final remoteFavorites = await _apiClient.favoritePodcasts();
    List<Podcast> favorites = List.generate(remoteFavorites.length, (index) {
      return Podcast.fromMap(remoteFavorites[index]);
    });
    // await _database.saveFavorites(favorites);
    // }

    final favourites = await _apiClient.favoritePodcasts();
    List<Podcast> favs = List.generate(favourites.length, (index) {
      return Podcast.fromMap(favourites[index]);
    });

    for (Podcast pod in favs) {
      String tmp = (pod.imageUrl) ?? "";
      if ((!(pod.imageUrl!.contains('http')) & (pod.imageUrl != null))) {
        pod.imageUrl = api + tmp;
      }
    }
    print("new fav");
    print(favs);

    return favs;
  }

  ///////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  @override
  Future<List<Podcast>> myPodcasts() async {
    final myPodcasts = await _apiClient.myPodcasts();
    print(myPodcasts);

    List<Podcast> pods = List.generate(myPodcasts.length, (index) {
      return Podcast.fromMap(myPodcasts[index]);
    });

    return pods;
  }

  ///////////////////////////////////////////////
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

  @override
  Future<void> deleteFromFavorite(String podcastId) async {
    await _apiClient.deleteFromFavorite(podcastId);
    await _database.deleteFromFavorite(podcastId);
  }

  @override
  Future<List<Podcast>> searchPodcasts(String query) async {
    final res = await _apiClient.searchPodcasts(query);
    List<Podcast> podcasts = List.generate(res.length, (index) {
      return Podcast.fromMap(res[index]);
    });

    for (Podcast pod in podcasts) {
      String tmp = (pod.imageUrl) ?? "";
      if ((!(pod.imageUrl!.contains('http')) & (pod.imageUrl != null))) {
        pod.imageUrl = api + tmp;
      }
    }
    print("new");
    print(podcasts);
    return podcasts;
  }

  @override
  Future<void> updatePodcast(dynamic podcast, String podcastId) async {
    final res = await _apiClient.UpdatePodcast(podcast, podcastId);
    await _database.deletePodcast(podcastId);
    // if (re != 201) {
    //   throw Exception("error getting the created podcast");
    // }
    // var dynamicpodcast = json.decode(res.body);

    // print('here too');
    await _database.savePodcast(Podcast.fromMap(podcast));
  }
}
