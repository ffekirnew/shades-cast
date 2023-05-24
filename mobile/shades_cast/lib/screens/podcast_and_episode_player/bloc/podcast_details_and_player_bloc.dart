import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/episode_item.dart';
import 'package:shades_cast/domain_layer/episode.dart';
import 'package:shades_cast/repository/podcast_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/domain_layer/podcast.dart';

import 'package:shades_cast/Infrustructure_layer/ui_components/episode_item.dart';
import 'package:shades_cast/repository/podcast_repository.dart';

import 'package:shades_cast/repository/database/podcast_database.dart';

part 'podcast_details_and_player_event.dart';
part 'podcast_details_and_player_state.dart';

class PodcastDetailsAndPlayerBloc
    extends Bloc<PodcastDetailsAndPlayerEvent, PodcastDetailsAndPlayerState> {
  PodcastDetailsAndPlayerBloc()
      : super(PodcastDetailsAndPlayerInitial(
            episodes: [], currentPlayingEpisode: 0)) {
    on<PodcastDetailsAndPlayerEvent>((event, emit) async {
      if (event is EpisodeItemClicked) {
        // int currentIndex = event.selectedIndex;
        emit(PodcastLoadingState());

        PodcastDatabase _database = PodcastDatabase.instance;
        PodcastApiClient _apiClient = PodcastApiClient();
        PodcastRepository podRepo =
            PodcastRepositoryImpl(_database, _apiClient);

        print('requested');
        final pod = await podRepo.getPodcastById('1');
        print('recieved');
        print(pod);

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

        // List<EpisodeItem> episodes = await podcast_repo.getEpisodes(
        //     selectedIndex: currentIndex, podcastId: event.podcastId);

        // emit(PodcastDetailEpisodes(
        //     episodes: episodes,
        //     currentPlayingEpisode: currentIndex,
        //     audioUrls: audioSrcs));
      } else if (event is SkipToNextButtonClicked) {
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
      } else if (event is SkipToPreviousButtonClicked) {
        int currentIndex = event.selectedIndex;

        if (currentIndex > 0) {
          //   PodcastRepo podcast_repo = PodcastRepo();
          //   List<String> audioSrcs = await podcast_repo.getEpisodeSrcs();

          //   List<EpisodeItem> episodes =
          //       await podcast_repo.getEpisodes(selectedIndex: currentIndex - 1);

          //   emit(PodcastDetailEpisodes(
          //       episodes: episodes,
          //       currentPlayingEpisode: currentIndex - 1,
          //       audioUrls: audioSrcs));
          // }
        } else {
          emit(PodcastLoadingState());

          PodcastDatabase _database = PodcastDatabase.instance;
          PodcastApiClient _apiClient = PodcastApiClient();
          PodcastRepository podRepo =
              PodcastRepositoryImpl(_database, _apiClient);

          final pod = await podRepo.getPodcastById('1');
          print(pod);

          // PodcastRepo podcast_repo = PodcastRepo();
          // List<EpisodeItem> episodes =
          //     await podcast_repo.getEpisodes(selectedIndex: 0);
          // List<String> audioSrcs = await podcast_repo.getEpisodeSrcs();
          // emit(PodcastDetailEpisodes(
          //     episodes: episodes,
          //     currentPlayingEpisode: 0,
          //     audioUrls: audioSrcs));
          // print('not clicked');
        }
      }
    });
  }
}
