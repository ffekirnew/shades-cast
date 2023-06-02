import 'package:shades_cast/main.dart' as app;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/regular_text_field.dart';
import 'package:shades_cast/screens/home/ui/homepage.dart';
import 'package:shades_cast/screens/login_and_signup/ui/login_and_signup.dart';
import 'package:shades_cast/screens/my_podcasts/ui/myPodcasts.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/ui/podcast_and_episode_player.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Tests', () {
    testWidgets(
      'Sign-up test',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.enterText(
            find.byType(RegularTextField).at(0), 'new_user_0w');
        await tester.enterText(
            find.byType(RegularTextField).at(1), 'new_user_0w@gmail.com');
        await tester.enterText(
            find.byType(RegularTextField).at(2), 'shades_cast_01');
        await tester.enterText(
            find.byType(RegularTextField).at(3), 'shades_cast_01');

        await tester.tap(find.byType(MaterialButton));
        await tester.pumpAndSettle();

        expect(find.byType(homepage), findsOneWidget);
      },
    );
    testWidgets(
      'Log-in test',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();
        await tester.tap(find.byType(TextButton));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(RegularTextField).at(0), 'admin');
        await tester.enterText(
            find.byType(RegularTextField).at(1), '123mypass');

        await tester.tap(find.byType(MaterialButton));
        await tester.pumpAndSettle();
        expect(find.byType(homepage), findsOneWidget);
      },
    );

    testWidgets(
      'Log-out test',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('home_page_menu_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('logout_button')));
        await tester.pumpAndSettle();

        expect(find.byType(LoginPage), findsOneWidget);
      },
    );

    testWidgets(
      'Change Username test',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('home_page_menu_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('account_settings_button')));
        await tester.pumpAndSettle();

        await tester.enterText(
            find.byType(TextFormField).at(0), 'new_username');
        await tester.enterText(
            find.byType(TextFormField).at(1), 'new_email@gmail.com');

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();
        expect(find.byKey(Key('errorMessage')), findsOneWidget);
      },
    );

    testWidgets(
      'Delete user',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('home_page_menu_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('delete_account_button')));
        await tester.pumpAndSettle();

        expect(find.byKey(Key('errorMessage')), findsOneWidget);
      },
    );
  });

  group('Business Feature #2: Fun Facts', () {
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

  group('Business Feature #3: Podcasts Test', () {
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
        await Future.delayed(const Duration(milliseconds: 2000));
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
    testWidgets(
      'Add episode integration test',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('home_page_menu_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('my_podcasts_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ListTile).at(0));
        await tester.pumpAndSettle();

        await tester.enterText(
            find.byType(TextFormField).at(0), 'The New Episode');
        await tester.enterText(find.byType(TextFormField).at(1),
            'This is a new description given by the integration test.');

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();
        expect(find.byKey(Key('errorMessage')), findsOneWidget);
      },
    );
    testWidgets(
      'Search and Play episode test',
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
    testWidgets(
      'Play episode test',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ListTile).at(0));

        expect(find.byType(PodcastPage), findsOneWidget);
      },
    );
  });
}
