import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/regular_text_field.dart';
import 'package:shades_cast/main.dart' as app;
import 'package:shades_cast/screens/home/ui/homepage.dart';
import 'package:shades_cast/screens/my_podcasts/ui/myPodcasts.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/ui/podcast_and_episode_player.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Podcasts Test', () {
    testWidgets(
      'Look at my podcasts',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('home_page_menu_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('my_podcasts_button')));
        await tester.pumpAndSettle();

        expect(find.byType(MyPodcastsPage), findsOneWidget);
      },
    );
    testWidgets(
      'Play one of my podcasts',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('home_page_menu_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('my_podcasts_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ListTile).at(0));
        await tester.pumpAndSettle();

        expect(find.byType(PodcastPage), findsOneWidget);
      },
    );
    testWidgets(
      'Edit one of my podcasts',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('home_page_menu_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('my_podcasts_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key("my_podcasts_edit_button")).at(0));
        await tester.pumpAndSettle();

        await tester.enterText(
            find.byType(TextFormField).at(0), 'new_username');
        await tester.enterText(
            find.byType(TextFormField).at(1), 'new_email@gmail.com');

        expect(find.byType(PodcastPage), findsOneWidget);
      },
    );
    testWidgets(
      'Delete one of my podcasts',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('home_page_menu_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('my_podcasts_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key("my_podcasts_delete_button")).at(0));
        await tester.pumpAndSettle();

        expect(find.byType(Dialog), findsOneWidget);
      },
    );
  });
}
