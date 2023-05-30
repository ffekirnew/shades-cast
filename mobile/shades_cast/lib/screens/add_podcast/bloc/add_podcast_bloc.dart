import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/repository/podcast_repository.dart';

part 'add_podcast_event.dart';
part 'add_podcast_state.dart';

class AddPodcastBloc extends Bloc<AddPodcastEvent, AddPodcastState> {
  AddPodcastBloc() : super(AddPodcastInitial()) {
    PodcastApiClient _apiClient = PodcastApiClient();
    PodcastDatabase _database = PodcastDatabase();

    on<AddPodcastEvent>((event, emit) async {
      if (event is PodcastSubmitted) {
        try {
          print('here in weird');
          PodcastRepository podRepo =
              PodcastRepositoryImpl(_database, _apiClient);
          print('podcastCreated');
          dynamic podcastCreated = event.createdPodcast;
          await podRepo.addPodcast(podcastCreated);
          //submit the podcast
          emit(AddPodcastSuccess());
        } catch (e) {
          print(e);
          emit(AddPodcastError());
        }
      }
    });
  }
}
