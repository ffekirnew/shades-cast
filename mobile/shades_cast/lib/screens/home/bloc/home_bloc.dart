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

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    List<Podcast> currentPodcasts = [];
    List<int> favoritedIds = [];
    PodcastApiClient _apiClient = PodcastApiClient();
    // FunfactApiClient _apiClientFunFact = FunfactApiClient();

    PodcastDatabase _database = PodcastDatabase.instance;
    // FunfactRepository funFactRep =
    //     FunfactRepositoryImpl(_database, _apiClientFunFact);
    Funfact currentFunFact =
        Funfact(title: "FunFact Title", body: "FunFact Body");

    on<HomeEvent>((event, emit) async {
      if (event is GetPodcasts) {
        emit(PodcastListerLoadingState());
        PodcastRepository podcastRepo =
            PodcastRepositoryImpl(_database, _apiClient);

        try {
          final List<Podcast> podcasts = await podcastRepo.getPodcasts();
          currentPodcasts = podcasts;
        } catch (e) {
          print('error occured');
          print(e);
        }

//------------------------ un comment for funfact fetching functionality ------------------------
        // Funfact funfact = await funFactRep.getFunfact();
        // currentFunFact = funfact;
        // print(funfact);

        emit(
          PodcastLoadedState(
              podcasts: currentPodcasts,
              favoritedPodcastId: favoritedIds,
              funFact: currentFunFact),
        );
      } else if (event is PodcasFavorited) {
        if (!(favoritedIds.contains(event.podcastId))) {
          favoritedIds.add(event.podcastId);
        } else {
          favoritedIds.remove(event.podcastId);
        }

        emit(PodcastLoadedState(
            podcasts: currentPodcasts,
            favoritedPodcastId: favoritedIds,
            funFact: currentFunFact));
      }
    });
  }
}
