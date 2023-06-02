import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shades_cast/repository/podcast_repository.dart';
import 'package:shades_cast/repository/database/podcast_database.dart';
import 'package:shades_cast/repository/funfact_repo.dart';
import 'package:shades_cast/repository/user_repo.dart';
import 'package:shades_cast/screens/home/bloc/home_bloc.dart';
import 'package:shades_cast/domain_layer/funfact.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/domain_layer/user.dart';

class MockPodcastDatabase extends Mock implements PodcastDatabase {}

class MockFunfactRepository extends Mock implements FunfactRepository {}

class MockUserRepo extends Mock implements UserRepo {}

void main() {
  late HomeBloc homeBloc;
  late MockPodcastDatabase mockPodcastDatabase;
  late MockFunfactRepository mockFunfactRepository;
  late MockUserRepo mockUserRepo;

  setUp(() {
    mockPodcastDatabase = MockPodcastDatabase();
    mockFunfactRepository = MockFunfactRepository();
    mockUserRepo = MockUserRepo();

    homeBloc = HomeBloc();
  });

  tearDown(() {
    homeBloc.close();
  });

  test('initial state is HomeInitial', () {
    expect(HomeInitial(
        currentUser: User(id: 1, name: '', email: '', password: '')));
  });

  test('emits PodcastLoadedState when GetPodcasts event is added', () async {
    final user = User(
        id: 1,
        name: 'John Doe',
        email: 'johndoe@example.com',
        password: 'password');
    final podcasts = [
      Podcast(id: 1, title: 'Podcast 1'),
      Podcast(id: 2, title: 'Podcast 2')
    ];
    final favoritedPodcasts = [Podcast(id: 1, title: 'Podcast 1')];
    final funfact =
        Funfact(id: '1', title: 'Fun Fact', body: 'This is a fun fact.');

    when(mockUserRepo.getUserDetail()).thenAnswer((_) async => user);
    when(mockPodcastDatabase.getPodcasts()).thenAnswer((_) async => podcasts);
    when(mockPodcastDatabase.getFavorites())
        .thenAnswer((_) async => favoritedPodcasts);
    when(mockFunfactRepository.getFunfact()).thenAnswer((_) async => funfact);

    final expectedStates = [
      PodcastListerLoadingState(currentUser: user, funfactVisibility: true),
      PodcastLoadedState(
        podcasts: podcasts,
        favoritedPodcastId: [1],
        funFact: funfact,
        currentUser: user,
        funfactVisibility: true,
      ),
    ];

    expectLater(homeBloc.stream, emitsInOrder(expectedStates));

    homeBloc.add(GetPodcasts());
  });

  // Add more tests for other events and scenarios if needed
}
