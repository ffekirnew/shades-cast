import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shade_cast/api_infrastructure.dart';
import 'package:shade_cast/infrastructure.dart';
import 'package:equatable/equatable.dart';
import 'package:shade_cast/podcast.dart';
import 'package:flutter/material.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  DataBase db = DataBase();
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async {
      var podcasts = await _fetchFromLocalStore();
      if (event is InitialEvent) {
        emit(Loading());

        if (podcasts == null) {
          await _fetchFromApi();
        }
        if (podcasts != null) {
          emit(Loaded(podcasts));
        } else {
          emit(Empty());
        }
      } else if (event is SwipeOutPodcast) {
        final int podcastInd = event.podcastIndex;
        podcasts = await _deleteFavorite(podcastInd);
        emit(Loaded(podcasts));
      } else if (event is TapToListen) {
        final Podcast podcast = event.podcast;
        emit(Navigation());
      }
    });
  }
  Future<List<Podcast>> _fetchFromLocalStore() {
    return db.getFavorites();
  }

  Future<List<Podcast>> _deleteFavorite(int ind) {
    return db.removeFavoritePodcast(ind);
  }

  Future<Podcast> _fetchFromApi() async {
    // final token = await _authService.getToken();
    // return FavoriteApi.fetchFavorites(token)
    return Future.delayed(
        Duration(seconds: 1)); // this was to avoid erroring, to be deleted
  }

  // void dispatch(event) {
  //   add(event);
  // }

  void dispose() {
    super.close();
  }
}
