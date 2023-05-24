import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_episode_event.dart';
part 'add_episode_state.dart';

class AddEpisodeBloc extends Bloc<AddEpisodeEvent, AddEpisodeState> {
  AddEpisodeBloc() : super(AddEpisodeInitial()) {
    on<AddEpisodeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
