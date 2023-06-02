import 'package:bloc_test/bloc_test.dart';
import 'package:shades_cast/domain_layer/episode.dart';
import 'package:test/test.dart';
// import 'package:/add_episode_bloc.dart';
import 'package:shades_cast/screens/add_epsiode/bloc/add_episode_bloc.dart';

void main() {
  group('AddEpisodeBloc', () {
    AddEpisodeBloc addEpisodeBloc = AddEpisodeBloc();

    setUp(() {
      addEpisodeBloc = AddEpisodeBloc();
    });

    tearDown(() {
      addEpisodeBloc.close();
    });

    test('emits [AddEpisodeSuccess] when EpsiodeSubmitted event is added', () {
      final episodeCreated = Episode(
          id: 1,
          podcastId: 2,
          title: "title",
          description: "description",
          audioUrl: "audioUrl",
          publishedDate: "publishedDate",
          durationInSeconds: 56);

      expectLater(
        addEpisodeBloc.stream,
        emitsInOrder([AddEpisodeSuccess()]),
      );

      addEpisodeBloc.add(EpsiodeSubmitted(createdEpsiode: episodeCreated));
    });

    test(
        'emits [AddEpisodeError] when an error occurs during episode submission',
        () {
      final episodeCreated = Episode(
          id: 1,
          podcastId: 2,
          title: "title",
          description: "description",
          audioUrl: "audioUrl",
          publishedDate: "publishedDate",
          durationInSeconds: 56);
      final error = 'error';
      final stackTrace = StackTrace.fromString('Simulated stack trace');

      expectLater(
        addEpisodeBloc.stream,
        emitsInOrder([AddEpisodeError()]),
      );

      addEpisodeBloc.add(EpsiodeSubmitted(createdEpsiode: episodeCreated));
      addEpisodeBloc.onError(error, stackTrace);
    });
  });
}
