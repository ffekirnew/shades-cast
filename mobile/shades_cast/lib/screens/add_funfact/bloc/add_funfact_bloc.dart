import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';

import 'package:shades_cast/repository/funfact_repo.dart';
import 'package:shades_cast/repository/podcast_repository.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/funfact_api_client.dart';

part 'add_funfact_event.dart';
part 'add_funfact_state.dart';

class AddFunfactBloc extends Bloc<AddFunfactEvent, AddFunfactState> {
  AddFunfactBloc() : super(AddFunfactInitial()) {
    PodcastDatabase _database = PodcastDatabase();
    FunfactApiClient _apiClient = FunfactApiClient();
    FunfactRepository funRepo = FunfactRepositoryImpl(_database, _apiClient);
    on<AddFunfactEvent>((event, emit) async {
      if (event is FunfactSubmitted) {
        try {
          final fact = event.fact;
          await funRepo.addFunfact(fact);
          emit(AddFunfactSuccessState());
        } catch (e) {
          print(e);
          emit(AddFunfactErrorState());
        }
      }
    });
  }
}
