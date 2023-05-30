import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
// import 'package:shades_cast/repository/podcast_repo.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';
import 'package:shades_cast/repository/podcast_repository.dart';

import 'package:shades_cast/domain_layer/funfact.dart';
import 'package:shades_cast/screens/home/ui/homepage.dart';
import 'package:shades_cast/repository/funfact_repo.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/funfact_api_client.dart';
import 'package:shades_cast/screens/my_podcasts/bloc/my_podcasts_bloc.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';

part 'favorite_podcasts_event.dart';
part 'favorite_podcasts_state.dart';

class FavoritePodcastsBloc
    extends Bloc<FavoritePodcastsEvent, FavoritePodcastsState> {
  FavoritePodcastsBloc() : super(FavoritePodcastsInitial()) {
    List<int> favoritedIds = [];
    PodcastApiClient _apiClient = PodcastApiClient();
    PodcastDatabase _database = PodcastDatabase();
    List<Podcast> currentPodcasts = [];

    on<FavoritePodcastsEvent>((event, emit) async {
      if (event is GetFavPodcasts) {
        emit(FavPodcastListerLoadingState());

        PodcastRepository podcastRepo =
            PodcastRepositoryImpl(_database, _apiClient);

        try {
          final List<Podcast> favPodcasts =
              await podcastRepo.favoritePodcasts();

          currentPodcasts = favPodcasts;
          favoritedIds = [];
          for (final pod in currentPodcasts) {
            favoritedIds.add(pod.id);
          }

          emit(
            FavPodcastLoadedState(
              podcasts: favPodcasts,
              favoritedPodcastId: favoritedIds,
            ),
          );
        } catch (e) {
          emit(FavPodcastErrorState());
        }
      } else if (event is FavPodcastFavorited) {
        print('fav ids');
        print(favoritedIds);
        print('current pods');

        PodcastRepository podcastRepo =
            PodcastRepositoryImpl(_database, _apiClient);
        if (currentPodcasts.length == 0) {
          try {
            final List<Podcast> favPodcasts =
                await podcastRepo.favoritePodcasts();

            currentPodcasts = favPodcasts;
            print(currentPodcasts);
          } catch (e) {
            print(e);
          }
        }
        if (!(favoritedIds.contains(event.podcastId))) {
          print('in');
          print(favoritedIds);
          print(event.podcastId);
          favoritedIds.add(event.podcastId);
          await podcastRepo.addToFavorite(event.podcastId.toString());
        } else {
          print('out');
          print(favoritedIds);
          favoritedIds.remove(event.podcastId);
        }
      }
      print('not here');
      print(favoritedIds);
      emit(
        FavPodcastLoadedState(
          podcasts: currentPodcasts,
          favoritedPodcastId: favoritedIds,
        ),
      );
    });
  }
}
