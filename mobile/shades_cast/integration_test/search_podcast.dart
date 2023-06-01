import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/regular_text_field.dart';
import 'package:shades_cast/main.dart' as app;
import 'package:shades_cast/screens/home/ui/homepage.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/ui/podcast_and_episode_player.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('login test', () {
    testWidgets(
      'Play episode test',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.enterText(
            find.byKey(Key('home_page_search_text_field')), 'Best');
        await tester.tap(find.byKey(Key('home_page_search_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ListTile).at(0));
        await tester.pumpAndSettle();

        expect(find.byType(PodcastPage), findsOneWidget);
      },
    );
  });
}
