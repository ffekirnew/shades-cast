import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:shades_cast/domain_layer/funfact.dart';
import 'package:shades_cast/repository/funfact_repo.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/funfact_api_client.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';

part 'funfact_event.dart';
part 'funfact_state.dart';

class FunfactBloc extends Bloc<FunfactEvent, FunfactState> {
  FunfactBloc() : super(FunfactInitial()) {
    FunfactApiClient _apiClient = FunfactApiClient();
    PodcastDatabase _database = PodcastDatabase();
    FunfactRepository funfactRepo =
        FunfactRepositoryImpl(_database, _apiClient);

    on<FunfactEvent>((event, emit) async {
      if (event is GetAllFunfacts) {
        try {
          emit(FunfactLoadingState());

          List<Funfact> funfacts = await funfactRepo.getFunfacts();

          emit(FunfactLoadedState(funfacts: funfacts));
        } catch (e) {
          print(e);
          emit(FunfactErrorState());
        }
      } else if (event is DeleteFunfact) {
        funfactRepo.deleteFunfact(event.funfactId);
      }
    });
  }
}
