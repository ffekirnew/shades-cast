import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:shades_cast/screens/favorite_podcasts/bloc/favorite_podcasts_bloc.dart';
import 'package:shades_cast/domain_layer/podcast.dart';

void main() {
  group('FavoritePodcastsBloc', () {
    FavoritePodcastsBloc favoritePodcastsBloc = FavoritePodcastsBloc();

    setUp(() {
      favoritePodcastsBloc = FavoritePodcastsBloc();
    });

    tearDown(() {
      favoritePodcastsBloc.close();
    });

    test('emits [FavPodcastLoadedState] when GetFavPodcasts event is added',
        () {
      final podcasts = [
        Podcast(id: 1, title: 'Podcast 1'),
        Podcast(id: 2, title: 'Podcast 2'),
      ];
      final favoritedPodcastIds = [1, 2];
      expectLater(
        favoritePodcastsBloc.stream,
        emitsInOrder([
          FavPodcastListerLoadingState(),
          FavPodcastLoadedState(
              podcasts: podcasts, favoritedPodcastId: favoritedPodcastIds)
        ]),
      );

      favoritePodcastsBloc.add(GetFavPodcasts());
    });
  });
}
