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

part 'my_podcasts_event.dart';
part 'my_podcasts_state.dart';

class MyPodcastsBloc extends Bloc<MyPodcastsEvent, MyPodcastsState> {
  MyPodcastsBloc() : super(MyPodcastsInitial()) {
    on<MyPodcastsEvent>((event, emit) {
      List<int> favoritedIds = [];
      PodcastApiClient _apiClient = PodcastApiClient();
      PodcastDatabase _database = PodcastDatabase.instance;

      on<MyPodcastsEvent>((event, emit) async {
        if (event is GetPodcasts) {
          emit(PodcastListerLoadingState());
          PodcastRepository podcastRepo =
              PodcastRepositoryImpl(_database, _apiClient);

          final List<Podcast> podcasts = await podcastRepo.getPodcasts();

          emit(
            PodcastLoadedState(
              podcasts: podcasts,
              favoritedPodcastId: favoritedIds,
            ),
          );
        }
      });
    });
  }
}
