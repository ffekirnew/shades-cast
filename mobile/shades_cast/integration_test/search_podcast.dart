import 'package:flutter_test/flutter_test.dart';
import 'package:my_podcast_app/models/podcast.dart';
import 'package:my_podcast_app/services/podcast_service.dart';

void main() {
  group('Search Integration Tests', () {
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

    testWidgets('Search for Podcast by Title', (WidgetTester tester) async {
      // Create a sample podcast to use for testing.
      final podcast = Podcast(
        id: '1',
        title: 'Awesome Podcast',
        description: 'This is an awesome podcast.',
      );

      // Add the podcast to the podcast service.
      podcastService.addPodcast(podcast);

      // Search for the podcast by its title.
      final searchResults = podcastService.searchPodcasts('Awesome Podcast');

      // Assert that the search results contain the podcast.
      expect(searchResults.contains(podcast), true);
    });

    testWidgets('Search for Podcast by Description', (WidgetTester tester) async {
      // Create a sample podcast to use for testing.
      final podcast = Podcast(
        id: '1',
        title: 'Awesome Podcast',
        description: 'This is an awesome podcast.',
      );

      // Add the podcast to the podcast service.
      podcastService.addPodcast(podcast);

      // Search for the podcast by its description.
      final searchResults = podcastService.searchPodcasts('awesome');

      // Assert that the search results contain the podcast.
      expect(searchResults.contains(podcast), true);
    });

    testWidgets('Search for Podcast - No Results', (WidgetTester tester) async {
      // Create a sample podcast to use for testing.
      final podcast = Podcast(
        id: '1',
        title: 'Awesome Podcast',
        description: 'This is an awesome podcast.',
      );

      // Add the podcast to the podcast service.
      podcastService.addPodcast(podcast);

      // Search for a non-existent podcast.
      final searchResults = podcastService.searchPodcasts('Non-existent Podcast');

      // Assert that the search results are empty.
      expect(searchResults.isEmpty, true);
    });
  });
}
import 'package:flutter_test/flutter_test.dart';
import 'package:my_podcast_app/models/podcast.dart';
import 'package:my_podcast_app/services/podcast_service.dart';

void main() {
  group('Search Integration Tests', () {
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

    testWidgets('Search for Podcast by Title', (WidgetTester tester) async {
      // Create a sample podcast to use for testing.
      final podcast = Podcast(
        id: '1',
        title: 'Awesome Podcast',
        description: 'This is an awesome podcast.',
      );

      // Add the podcast to the podcast service.
      podcastService.addPodcast(podcast);

      // Search for the podcast by its title.
      final searchResults = podcastService.searchPodcasts('Awesome Podcast');

      // Assert that the search results contain the podcast.
      expect(searchResults.contains(podcast), true);
    });

    testWidgets('Search for Podcast by Description', (WidgetTester tester) async {
      // Create a sample podcast to use for testing.
      final podcast = Podcast(
        id: '1',
        title: 'Awesome Podcast',
        description: 'This is an awesome podcast.',
      );

      // Add the podcast to the podcast service.
      podcastService.addPodcast(podcast);

      // Search for the podcast by its description.
      final searchResults = podcastService.searchPodcasts('awesome');

      // Assert that the search results contain the podcast.
      expect(searchResults.contains(podcast), true);
    });

    testWidgets('Search for Podcast - No Results', (WidgetTester tester) async {
      // Create a sample podcast to use for testing.
      final podcast = Podcast(
        id: '1',
        title: 'Awesome Podcast',
        description: 'This is an awesome podcast.',
      );

      // Add the podcast to the podcast service.
      podcastService.addPodcast(podcast);

      // Search for a non-existent podcast.
      final searchResults = podcastService.searchPodcasts('Non-existent Podcast');

      // Assert that the search results are empty.
      expect(searchResults.isEmpty, true);
    });
  });
}
