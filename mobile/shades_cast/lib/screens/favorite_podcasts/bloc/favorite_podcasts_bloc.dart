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
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';

part 'favorite_podcasts_event.dart';
part 'favorite_podcasts_state.dart';

class FavoritePodcastsBloc
    extends Bloc<FavoritePodcastsEvent, FavoritePodcastsState> {
  FavoritePodcastsBloc() : super(FavoritePodcastsInitial()) {
    on<FavoritePodcastsEvent>((event, emit) async {
      List<int> favoritedIds = [];
      PodcastApiClient _apiClient = PodcastApiClient();
      PodcastDatabase _database = PodcastDatabase.instance;
      List<Podcast> currentPodcasts = [];

      if (event is GetFavPodcasts) {
        emit(FavPodcastListerLoadingState());
        PodcastRepository podcastRepo =
            PodcastRepositoryImpl(_database, _apiClient);

        final List<Podcast> favPodcasts = await podcastRepo.favoritePodcasts();

        currentPodcasts = favPodcasts;
        emit(
          FavPodcastLoadedState(
            podcasts: favPodcasts,
            favoritedPodcastId: favoritedIds,
          ),
        );
      } else if (event is FavPodcastFavorited) {
        if (!(favoritedIds.contains(event.podcastId))) {
          favoritedIds.add(event.podcastId);
        } else {
          favoritedIds.remove(event.podcastId);
        }

        emit(FavPodcastLoadedState(
            podcasts: currentPodcasts, favoritedPodcastId: favoritedIds));
      }
    });
  }
}
