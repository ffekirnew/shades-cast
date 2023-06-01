// Write code to implement test.
// Run the test and verify that it fails.
// Write code to implement the deleteEpisode method in the Podcast class.
// Run the test and verify that it passes.
test('deletePodcast', () async {
  // Create a podcast
  final podcast = Podcast(
    title: 'Dart News and Updates',
    link: 'https://dart.dev/podcasts/dartcast',
    description: 'The latest news, views and updates from the Dart team.',
    imageUrl: 'https://dart.dev/assets/shared/dart/icon/64.png',
  );

  // Add the podcast to the database
  await podcast.save();

  // Delete the podcast
  await podcast.delete();

  // Verify that the podcast is no longer in the database
  final podcasts = await Podcast().select().toList();
  expect(podcasts.length, 0);
});