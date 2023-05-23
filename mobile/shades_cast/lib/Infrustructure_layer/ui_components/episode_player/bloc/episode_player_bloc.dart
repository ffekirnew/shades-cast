import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'episode_player_event.dart';
part 'episode_player_state.dart';

class EpisodePlayerBloc extends Bloc<EpisodePlayerEvent, EpisodePlayerState> {
  EpisodePlayerBloc() : super(EpisodePlayerInitial()) {
    on<EpisodePlayerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
