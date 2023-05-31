import 'package:flutter_test/flutter_test.dart';
import 'package:my_podcast_app/models/podcast.dart';
import 'package:my_podcast_app/services/podcast_service.dart';

void main() {
  group('Unfavorite Podcasts Integration Tests', () {
    // Declare a variable to hold the instance of the PodcastService.
    PodcastService podcastService;

    // Set up the necessary dependencies before running the tests.
    setUp(() {
      podcastService = PodcastService();
    });

    // Clean up any resources after running the tests.
    tearDown(() {
      podcastService = null;
    });

    testWidgets('Unmark Podcast as Favorite', (WidgetTester tester) async {
      // Create a sample podcast to use for testing.
      final podcast = Podcast(
        id: '1',
        title: 'Awesome Podcast',
        description: 'This is an awesome podcast.',
      );

      // Mark the podcast as a favorite.
      await podcastService.markPodcastAsFavorite(podcast);

      // Unmark the podcast as a favorite.
      await podcastService.unmarkPodcastAsFavorite(podcast);

      // Retrieve the list of favorite podcasts.
      final favorites = podcastService.getFavoritePodcasts();

      // Assert that the list of favorites does not contain the podcast.
      expect(favorites.contains(podcast), false);
    });
  });
}
