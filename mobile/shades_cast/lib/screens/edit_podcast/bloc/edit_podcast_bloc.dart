import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/repository/podcast_repository.dart';

part 'edit_podcast_event.dart';
part 'edit_podcast_state.dart';

class EditPodcastBloc extends Bloc<EditPodcastEvent, EditPodcastState> {
  EditPodcastBloc() : super(EditPodcastInitial()) {
    PodcastApiClient _apiClient = PodcastApiClient();
    PodcastDatabase _database = PodcastDatabase();

    on<EditPodcastEvent>((event, emit) async {
      if (event is EditPodcastSubmitted) {
        try {
          PodcastRepository podRepo =
              PodcastRepositoryImpl(_database, _apiClient);
          dynamic podcastModified = event.modifiedPodcast;

          // await podRepo.EditPodcast(podcastModified, event.podcastId);
          print('episodeModified');
          //submit the podcast
          emit(EditPodcastSuccess());
        } catch (e) {
          print(e);
          emit(EditPodcastError());
        }
      }
    });
  }
}
