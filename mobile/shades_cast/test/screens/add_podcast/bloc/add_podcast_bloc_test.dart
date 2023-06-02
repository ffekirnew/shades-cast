import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:shades_cast/screens/add_podcast/bloc/add_podcast_bloc.dart';

void main() {
  group('AddPodcastBloc', () {
    AddPodcastBloc addPodcastBloc = AddPodcastBloc();

    setUp(() {
      addPodcastBloc = AddPodcastBloc();
    });

    tearDown(() {
      addPodcastBloc.close();
    });

    test('emits [AddPodcastSuccess] when PodcastSubmitted event is added', () {
      final podcastCreated =
          {}; // Replace {} with the podcast object you want to use for testing

      expectLater(
        addPodcastBloc.stream,
        emitsInOrder([AddPodcastSuccess()]),
      );

      addPodcastBloc.add(PodcastSubmitted(createdPodcast: podcastCreated));
    });

    test(
        'emits [AddPodcastError] when an error occurs during podcast submission',
        () {
      final podcastCreated =
          {}; // Replace {} with the podcast object you want to use for testing
      final error =
          'Some error message'; // Replace 'Some error message' with the error message you want to simulate

      expectLater(
        addPodcastBloc.stream,
        emitsInOrder([AddPodcastError()]),
      );

      addPodcastBloc.add(PodcastSubmitted(createdPodcast: podcastCreated));
      // addPodcastBloc.onError(error);
    });
  });
}
