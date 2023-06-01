// Implement a test for deleting a podcast
// Use the test to drive the implementation of the deleteEpisode method
// in the Podcast class
test('deleteEpisode', () async {
  // Create a podcast
  final podcast = Podcast(
    title: 'Dart News and Updates',
    link: 'https://dart.dev/podcasts/dartcast',
    description: 'The latest news, views and updates from the Dart team.',
    imageUrl: 'https://dart.dev/assets/shared/dart/icon/64.png',
  );

  // Add the podcast to the database
  await podcast.save();

  // Create an episode
  final episode = Episode(
    title: 'Dart 2.7 and null safety tech preview',
    link: 'https://dart.dev/podcasts/dartcast/episodes/2020-02-21',
    description:
        'Dart 2.7 is now available with a preview of null safety. Null safety is one of the biggest changes to Dart since we launched Dart 2, and brings sound null safety to Dart.',
    published: DateTime.parse('2020-02-21'),
    podcast: podcast,
  );

  // Add the episode to the database
  await episode.save();

  // Delete the episode
  await episode.delete();

  // Verify that the episode is no longer in the database
  final episodes = await Episode().select().toList();
  expect(episodes.length, 0);
});