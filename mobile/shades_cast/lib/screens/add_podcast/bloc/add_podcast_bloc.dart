import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_podcast_event.dart';
part 'add_podcast_state.dart';

class AddPodcastBloc extends Bloc<AddPodcastEvent, AddPodcastState> {
  AddPodcastBloc() : super(AddPodcastInitial()) {
    on<AddPodcastEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
