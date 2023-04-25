import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'podcast_detail_event.dart';
part 'podcast_detail_state.dart';

class PodcastDetailBloc extends Bloc<PodcastDetailEvent, PodcastDetailState> {
  PodcastDetailBloc() : super(PodcastDetailInitial()) {
    on<PodcastDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
