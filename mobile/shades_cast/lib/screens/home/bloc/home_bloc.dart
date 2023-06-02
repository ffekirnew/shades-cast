import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
// import 'package:shades_cast/repository/podcast_repo.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';
import 'package:shades_cast/repository/podcast_repository.dart';

import 'package:shades_cast/domain_layer/funfact.dart';
import 'package:shades_cast/domain_layer/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shades_cast/repository/user_repo.dart';
import 'package:shades_cast/screens/home/ui/homepage.dart';
import 'package:shades_cast/repository/funfact_repo.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/funfact_api_client.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeInitial(
            currentUser: User(id: 1, name: '', email: '', password: ''))) {
    List<Podcast> currentPodcasts = [];
    List<int> favoritedIds = [];
    PodcastApiClient _apiClient = PodcastApiClient();
    PodcastDatabase _database = PodcastDatabase();
    UserRepo userRepo = UserRepo();
    User currentUser = User(id: 1, name: '', email: '', password: '');

    FunfactApiClient _apiClientFunFact = FunfactApiClient();
    FunfactRepository funFactRep =
        FunfactRepositoryImpl(_database, _apiClientFunFact);

    Funfact currentFunFact = Funfact(title: "", body: "", id: "");

    bool funfactVisibility = true;

    on<HomeEvent>(
      (event, emit) async {
        if (event is GetPodcasts) {
          if (currentUser.name == '') {
            print('called');
            User user = await userRepo.getUserDetail();
            currentUser = user;
          }
          if (currentUser.name == '') {
            User user = await userRepo.getUserDetail();
            currentUser = user;
          }

          emit(PodcastListerLoadingState(
              currentUser: currentUser, funfactVisibility: funfactVisibility));
          PodcastRepository podcastRepo =
              PodcastRepositoryImpl(_database, _apiClient);

          try {
            final List<Podcast> podcasts = await podcastRepo.getPodcasts();

            currentPodcasts = podcasts;

            Funfact funfact = await funFactRep.getFunfact();
            // print(funfact);

            currentFunFact = funfact;
            final List<Podcast> favPodcasts =
                await podcastRepo.favoritePodcasts();
            print('favs');
            print(favPodcasts);

            favoritedIds = [];
            for (final pod in favPodcasts) {
              favoritedIds.add(pod.id);
            }

            emit(
              PodcastLoadedState(
                  podcasts: currentPodcasts,
                  favoritedPodcastId: favoritedIds,
                  funFact: currentFunFact,
                  currentUser: currentUser,
                  funfactVisibility: funfactVisibility),
            );
          } catch (e) {
            // print('error occured here in home bloc');
            // print(e);
            emit(PodcastsErrorState(
                currentUser: currentUser,
                funfactVisibility: funfactVisibility));
          }
        } else if (event is PodcasFavorited) {
          PodcastRepository podcastRepo =
              PodcastRepositoryImpl(_database, _apiClient);
          if (!(favoritedIds.contains(event.podcastId))) {
            favoritedIds.add(event.podcastId);
            await podcastRepo.addToFavorite(event.podcastId.toString());
          } else {
            await podcastRepo.deleteFromFavorite(event.podcastId.toString());
            favoritedIds.remove(event.podcastId);
          }

          emit(PodcastLoadedState(
              podcasts: currentPodcasts,
              favoritedPodcastId: favoritedIds,
              funFact: currentFunFact,
              currentUser: currentUser,
              funfactVisibility: funfactVisibility));
        } else if (event is PodcastSearched) {
          if (currentUser.name == '') {
            User user = await userRepo.getUserDetail();
            currentUser = user;
          }

          emit(PodcastListerLoadingState(
              currentUser: currentUser, funfactVisibility: funfactVisibility));
          PodcastRepository podcastRepo =
              PodcastRepositoryImpl(_database, _apiClient);

          try {
            final List<Podcast> podcasts =
                await podcastRepo.searchPodcasts(event.searchTerm);
            currentPodcasts = podcasts;
            // print('search result');
            // print(currentPodcasts);

            emit(
              PodcastLoadedState(
                  podcasts: currentPodcasts,
                  favoritedPodcastId: favoritedIds,
                  funFact: currentFunFact,
                  currentUser: currentUser,
                  funfactVisibility: funfactVisibility),
            );
          } catch (e) {
            // print(e);
            emit(PodcastsErrorState(
              currentUser: currentUser,
              funfactVisibility: funfactVisibility,
            ));
          }
        } else if (event is FunfactWindowClosed) {
          funfactVisibility = false;
          BlocProvider.of<HomeBloc>(event.context).add(GetPodcasts());
        } else if (event is DeleteUserAccount) {
          try {
            await userRepo.deleteUser(event.userId.toString());
            Navigator.pushReplacementNamed(event.context, '/');
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.remove('token');
          } catch (e) {
            // print(e);
          }
        }
      },
    );
  }
}
