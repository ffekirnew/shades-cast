import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/repository/podcast_repository.dart';

part 'add_episode_event.dart';
part 'add_episode_state.dart';

class AddEpisodeBloc extends Bloc<AddEpisodeEvent, AddEpisodeState> {
  AddEpisodeBloc() : super(AddEpisodeInitial()) {
    PodcastApiClient _apiClient = PodcastApiClient();
    PodcastDatabase _database = PodcastDatabase.instance;

    on<AddEpisodeEvent>((event, emit) async {
      if (event is EpsiodeSubmitted) {
        try {
          print('here in bloc of add episode');

          PodcastRepository podRepo =
              PodcastRepositoryImpl(_database, _apiClient);

          dynamic episodeCreated = event.createdEpsiode;

          await podRepo.addEpisode(episodeCreated);
          print('episodeCreated');
          //submit the episode
          emit(AddEpisodeSuccess());
        } catch (e) {
          print(e);
          emit(AddEpisodeError());
        }
      }
    });
  }
}
