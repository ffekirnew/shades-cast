import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
// import 'package:shades_cast/repository/podcast_repo.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';
import 'package:shades_cast/repository/podcast_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    List<Podcast> currentPodcasts = [];
    List<int> favoritedIds = [];
    PodcastApiClient _apiClient = PodcastApiClient();
    PodcastDatabase _database = PodcastDatabase.instance;

    on<HomeEvent>((event, emit) async {
      if (event is GetPodcasts) {
        PodcastRepository podcastRepo =
            PodcastRepositoryImpl(_database, _apiClient);

        final List<Podcast> podcasts = await podcastRepo.getPodcasts();
        currentPodcasts = podcasts;

        emit(PodcastLoadedState(
            podcasts: podcasts, favoritedPodcastId: favoritedIds));
      } else if (event is PodcasFavorited) {
        if (!(favoritedIds.contains(event.podcastId))) {
          favoritedIds.add(event.podcastId);
        } else {
          favoritedIds.remove(event.podcastId);
        }

        emit(PodcastLoadedState(
            podcasts: currentPodcasts, favoritedPodcastId: favoritedIds));
      }
    });
  }
}
