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

  group('Showing fun facts editing capability for admin users only', () {
    testWidgets(
      'With administrator account, show editing capability',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.tap(find.byType(TextButton));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(RegularTextField).at(0), 'firaol');
        await tester.enterText(find.byType(RegularTextField).at(1), 'admin');

        await tester.tap(find.byType(MaterialButton));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('home_page_menu_button')));
        await tester.pumpAndSettle();

        expect(find.byKey(Key("admin_funfacts_button")), findsOneWidget);
      },
    );
    testWidgets(
      'Without an administrator account, do not show editing capability',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.tap(find.byType(TextButton));
        await tester.pumpAndSettle();

        await tester.enterText(
            find.byType(RegularTextField).at(0), 'genericuser');
        await tester.enterText(find.byType(RegularTextField).at(1), 'testuser');

        await tester.tap(find.byType(MaterialButton));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('home_page_menu_button')));
        await tester.pumpAndSettle();

        expect(find.byKey(Key("admin_funfacts_button")), findsNothing);
      },
    );
  });
}
