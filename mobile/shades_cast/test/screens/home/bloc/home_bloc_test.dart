import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:shades_cast/screens/home/bloc/home_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:shades_cast/repository/funfact_repo.dart';
import 'package:shades_cast/repository/podcast_repository.dart';
import 'package:shades_cast/repository/user_repo.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/domain_layer/user.dart';
import 'package:shades_cast/domain_layer/funfact.dart';

void main() {
  group('HomeBloc', () {
    HomeBloc homeBloc = HomeBloc();

    setUp(() {
      homeBloc = HomeBloc();
    });

    tearDown(() {
      homeBloc.close();
    });

    test(
        'emits [PodcastListerLoadingState, PodcastLoadedState] when GetPodcasts event is added',
        () {
      final mockCurrentUser =
          User(id: 1, name: 'Shamil Bedru', email: '', password: '');

      final mockPodcasts = [
        Podcast(id: 1, title: 'Podcast 1'),
        Podcast(id: 2, title: 'Podcast 2'),
      ];

      final mockFavoritedPodcastIds = [1];

      final mockFunFact =
          Funfact(title: 'Fun Fact Title', body: 'Fun Fact Body');

      final userRepository = MockUserRepository();
      final podcastRepository = MockPodcastRepository();
      final funfactRepository = MockFunfactRepository();

      when(userRepository.getUserDetail())
          .thenAnswer((_) async => mockCurrentUser);
      when(podcastRepository.getPodcasts())
          .thenAnswer((_) async => mockPodcasts);
      when(funfactRepository.getFunfact()).thenAnswer((_) async => mockFunFact);
      when(podcastRepository.favoritePodcasts())
          .thenAnswer((_) async => mockPodcasts);

      expectLater(
        homeBloc.stream,
        emitsInOrder([
          PodcastListerLoadingState(currentUser: mockCurrentUser),
          PodcastLoadedState(
            podcasts: mockPodcasts,
            favoritedPodcastId: mockFavoritedPodcastIds,
            funFact: mockFunFact,
            currentUser: mockCurrentUser,
          ),
        ]),
      );

      homeBloc.add(GetPodcasts());
    });

    test('emits [PodcastLoadedState] when PodcasFavorited event is added', () {
      final mockCurrentUser =
          User(id: 1, name: 'Shamil Bedru', email: '', password: '');

      final mockPodcasts = [
        Podcast(id: 1, title: 'Podcast 1'),
        Podcast(id: 2, title: 'Podcast 2'),
      ];

      final mockFavoritedPodcastIds = [1, 2];

      final userRepository = MockUserRepository();
      final podcastRepository = MockPodcastRepository();

      when(userRepository.getUserDetail())
          .thenAnswer((_) async => mockCurrentUser);
      when(podcastRepository.favoritePodcasts())
          .thenAnswer((_) async => mockPodcasts);

      expectLater(
        homeBloc.stream,
        emitsInOrder([
          PodcastLoadedState(
            podcasts: mockPodcasts,
            favoritedPodcastId: mockFavoritedPodcastIds,
            funFact: Funfact(title: '', body: ''),
            currentUser: mockCurrentUser,
          ),
        ]),
      );

      homeBloc.add(PodcasFavorited(podcastId: 2));
    });

    test('closes the bloc properly', () {
      expectLater(homeBloc.stream, emitsDone);
      homeBloc.close();
    });
  });
}

// MockUserRepository class for testing purposes
class MockUserRepository extends Mock implements UserRepo {}

// MockPodcastRepository class for testing purposes
class MockPodcastRepository extends Mock implements PodcastRepository {}

// MockFunfactRepository class for testing purposes
class MockFunfactRepository extends Mock implements FunfactRepository {}

// MockUser class for testing purposes
class MockUser extends Mock implements User {}

// MockPodcast class for testing purposes
class MockPodcast extends Mock {}
