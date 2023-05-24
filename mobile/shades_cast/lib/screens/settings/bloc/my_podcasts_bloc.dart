import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_podcasts_event.dart';
part 'my_podcasts_state.dart';

class MyPodcastsBloc extends Bloc<MyPodcastsEvent, MyPodcastsState> {
  MyPodcastsBloc() : super(MyPodcastsInitial()) {
    on<MyPodcastsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
