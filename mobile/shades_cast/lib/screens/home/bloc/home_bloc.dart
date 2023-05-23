import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:shades_cast/repository/podcast_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    List<Podcast> currentPodcasts = [];
    List<int> favoritedIds = [];
    on<HomeEvent>((event, emit) async {
      if (event is GetPodcasts) {
        List<Podcast> podcasts;
        emit(PodcastSearchingState());
        final podcastClient = PodcastApiClient();
        final podcastRepo = PodcastRepo();
        print("podcasts are requested from bloc");

        podcasts = await podcastRepo.getPodcasts(podcastClient: podcastClient);
        currentPodcasts = podcasts;
        print("podcasts are here in bloc");
        emit(PodcastLoadedState(
            podcasts: podcasts, favoritedPodcastId: favoritedIds));
      } else if (event is PodcasFavorited) {
        print("Podcast favorited");
        if (!(favoritedIds.contains(event.podcastId))) {
          favoritedIds.add(event.podcastId);
        } else {
          favoritedIds.remove(event.podcastId);
        }
        print(favoritedIds);
        emit(PodcastLoadedState(
            podcasts: currentPodcasts, favoritedPodcastId: favoritedIds));
      }
    });
  }
}
