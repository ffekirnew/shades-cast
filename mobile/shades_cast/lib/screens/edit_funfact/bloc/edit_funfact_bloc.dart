import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/repository/podcast_repository.dart';
import 'package:shades_cast/repository/podcast_repository.dart';
import 'package:shades_cast/repository/funfact_repo.dart';

import 'package:shades_cast/Infrustructure_layer/api_clients/funfact_api_client.dart';

part 'edit_funfact_event.dart';
part 'edit_funfact_state.dart';

class EditFunfactBloc extends Bloc<EditFunfactEvent, EditFunfactState> {
  EditFunfactBloc() : super(EditFunfactInitial()) {
    FunfactApiClient _apiClient = FunfactApiClient();
    PodcastDatabase _database = PodcastDatabase();

    on<EditFunfactEvent>((event, emit) async {
      if (event is EditFunfactSubmitted) {
        try {
          FunfactRepository podRepo =
              FunfactRepositoryImpl(_database, _apiClient);
          // dynamic podcastModified = event.modifiedPodcast;

          // await podRepo.updatePodcast(
          //     podcastModified, event.podcastId.toString());
          print('PodcastModified');
          //submit the podcast
          emit(EditFunfactSuccess());
        } catch (e) {
          print(e);
          emit(EditFunfactError());
        }
      }
    });
  }
}
