import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:shades_cast/domain_layer/episode.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';
import 'package:shades_cast/repository/podcast_repository.dart';
import 'package:shades_cast/screens/add_epsiode/bloc/add_episode_bloc.dart';

// Create a mock class for the dependencies (PodcastApiClient, PodcastDatabase, PodcastRepository)
class MockPodcastApiClient extends Mock implements PodcastApiClient {}

class MockPodcastDatabase extends Mock implements PodcastDatabase {}

class MockPodcastRepository extends Mock implements PodcastRepository {}

void main() {
  group('AddEpisodeBloc', () {
    late AddEpisodeBloc addEpisodeBloc;
    late MockPodcastApiClient mockPodcastApiClient;
    late MockPodcastDatabase mockPodcastDatabase;
    late MockPodcastRepository mockPodcastRepository;

    setUp(() {
      mockPodcastApiClient = MockPodcastApiClient();
      mockPodcastDatabase = MockPodcastDatabase();
      mockPodcastRepository = MockPodcastRepository();

      addEpisodeBloc = AddEpisodeBloc(
        podcastApiClient: mockPodcastApiClient,
        podcastDatabase: mockPodcastDatabase,
        podcastRepository: mockPodcastRepository,
      );
    });

    test('should emit AddEpisodeSuccess when episode is submitted successfully',
        () {
      final episode = Episode(
          id: 1,
          title: 'test',
          description: 'test',
          podcastId: 1,
          publishedDate: DateTime.now(),
          audioUrl: 'test',
          durationInSeconds: 3500);

      when(mockPodcastRepository.addEpisode(episode)).thenAnswer((_) async {});

      expectLater(
        addEpisodeBloc.stream,
        emitsInOrder([AddEpisodeSuccess()]),
      );

      addEpisodeBloc.add(EpsiodeSubmitted(createdEpsiode: episode));
    });

    test(
        'should emit AddEpisodeError when an error occurs during episode submission',
        () {
      final episode = Episode(
          id: 1,
          title: 'test',
          description: 'test',
          podcastId: 1,
          publishedDate: DateTime.now(),
          audioUrl: 'test',
          durationInSeconds: 3500);

      when(mockPodcastRepository.addEpisode(episode)).thenThrow(Exception());

      expectLater(
        addEpisodeBloc.stream,
        emitsInOrder([AddEpisodeError()]),
      );

      addEpisodeBloc.add(EpsiodeSubmitted(createdEpsiode: episode));
    });
  });
}
