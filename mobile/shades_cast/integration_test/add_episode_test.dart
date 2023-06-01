// Implement the integration test for adding a podcast episode.
test('Add Episode Test', () async {
  // Build our app and trigger a frame.
  await tester.pumpWidget(new ShadesCastApp());

  // Tap the add episode button.
  await tester.tap(find.byIcon(Icons.add));

  // Wait for the add episode page to load.
  await tester.pump();

  // Enter the episode title.
  await tester.enterText(find.byKey(Key('title')), 'Test Episode');

  // Enter the episode description.
  await tester.enterText(find.byKey(Key('description')), 'Test Description');

  // Enter the episode URL.
  await tester.enterText(find.byKey(Key('url')), 'http://example.com');

  // Tap the save button.
  await tester.tap(find.byKey(Key('save')));

  // Wait for the episode to be added.
  await tester.pump();

  // Verify that the episode was added.
  expect(find.text('Test Episode'), findsOneWidget);
  expect(find.text('Test Description'), findsOneWidget);
  expect(find.text('http://example.com'), findsOneWidget);
});
