import 'package:bloc/bloc.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/episode_item.dart';
import 'package:shades_cast/domain_layer/episode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/domain_layer/podcast.dart';

import 'package:shades_cast/repository/podcast_repository.dart';

import 'package:shades_cast/repository/database/podcast_database.dart';

part 'podcast_details_and_player_event.dart';
part 'podcast_details_and_player_state.dart';

class PodcastDetailsAndPlayerBloc
    extends Bloc<PodcastDetailsAndPlayerEvent, PodcastDetailsAndPlayerState> {
  PodcastDetailsAndPlayerBloc()
      : super(PodcastDetailsAndPlayerInitial(
            episodes: [], currentPlayingEpisode: 0)) {
    int currentEpisode = 0;
    List<Episode> currentEpisodes = [];
    bool isFromMyPodcasts = false;
    Podcast currentPodcast = Podcast(
        id: 1,
        title: '',
        author: '',
        description: '',
        imageUrl: '',
        categories: []);

    on<PodcastDetailsAndPlayerEvent>((event, emit) async {
      if (event is PodcastDetailPageOpened) {
        // int currentIndex = event.selectedIndex;
        isFromMyPodcasts = event.isFromMyPodcasts;
        emit(PodcastLoadingState());

        PodcastDatabase _database = PodcastDatabase();
        PodcastApiClient _apiClient = PodcastApiClient();
        PodcastRepository podRepo =
            PodcastRepositoryImpl(_database, _apiClient);

        try {
          print('here first');
          final Podcast pod =
              await podRepo.getPodcastById(event.podcastId.toString());

          currentPodcast = pod;
          print('herreee');
          List<Episode> episodes =
              await podRepo.getEpisodes(event.podcastId.toString());

          currentEpisodes = episodes;
          print(episodes);
          print('ended');
          emit(PodcastDetailEpisodes(
              episodes: currentEpisodes,
              currentPlayingEpisode:
                  currentEpisode % (max(currentEpisodes.length, 1)),
              podcast: pod,
              isFromMyPodcasts: isFromMyPodcasts));
        } catch (e) {
          print(e);
          emit(PodcastDetailsAndPlayerErrorState());
        }
      } else if (event is SkipToNextButtonClicked) {
        currentEpisode += 1;

        emit(PodcastDetailEpisodes(
            episodes: currentEpisodes,
            currentPlayingEpisode:
                currentEpisode % (max(currentEpisodes.length, 1)),
            podcast: currentPodcast,
            isFromMyPodcasts: isFromMyPodcasts));
      } else if (event is SkipToPreviousButtonClicked) {
        currentEpisode -= 1;
        print(currentEpisode);

        emit(PodcastDetailEpisodes(
            episodes: currentEpisodes,
            currentPlayingEpisode:
                currentEpisode % (max(currentEpisodes.length, 1)),
            podcast: currentPodcast,
            isFromMyPodcasts: isFromMyPodcasts));
      } else if (event is EpisodeItemClicked) {
        currentEpisode = event.selectedIndex;
        emit(PodcastDetailEpisodes(
            episodes: currentEpisodes,
            currentPlayingEpisode:
                currentEpisode % (max(currentEpisodes.length, 1)),
            podcast: currentPodcast,
            isFromMyPodcasts: isFromMyPodcasts));
      }
    });
  }
}


        // List<String> audioSrcs = await podcast_repo.getEpisodeSrcs();

        //###############new###############################
        // print('hill climbing');
        // Map pd = await podcast_repo.getPodcast(podcastId: 0);
        // Podcast podcast = Podcast(
        //     id: pd['id'],
        //     title: pd['title'],
        //     author: pd['author'],
        //     description: pd['description'],
        //     imageUrl: pd['imageUrl'],
        //     categories: pd['categories']);
        // print('in bloc $podcast');
        //###############new###############################




          // List<String> audioSrcs = await podcast_repo.getEpisodeSrcs();

          //###############new###############################
          // print('hill climbing');
          // Map pd = await podcast_repo.getPodcast(podcastId: 0);
          // Podcast podcast = Podcast(
          //     id: pd['id'],
          //     title: pd['title'],
          //     author: pd['author'],
          //     description: pd['description'],
          //     imageUrl: pd['imageUrl'],
          //     categories: pd['categories']);
          // print('in bloc $podcast');




          //   PodcastRepo podcast_repo = PodcastRepo();
          //   List<String> audioSrcs = await podcast_repo.getEpisodeSrcs();

          //   List<EpisodeItem> episodes =
          //       await podcast_repo.getEpisodes(selectedIndex: currentIndex - 1);

          //   emit(PodcastDetailEpisodes(
          //       episodes: episodes,
          //       currentPlayingEpisode: currentIndex - 1,
          //       audioUrls: audioSrcs));
          // }


                  // int currentIndex = event.selectedIndex;
        // PodcastRepo podcast_repo = PodcastRepo();
        // List<String> audioSrcs = await podcast_repo.getEpisodeSrcs();
        // if (currentIndex < audioSrcs.length - 1) {
        //   List<EpisodeItem> episodes =
        //       await podcast_repo.getEpisodes(selectedIndex: currentIndex + 1);
        //   emit(PodcastDetailEpisodes(
        //       episodes: episodes,
        //       currentPlayingEpisode: currentIndex + 1,
        //       audioUrls: audioSrcs));
        // }