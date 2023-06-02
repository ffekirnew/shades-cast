import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/regular_text_field.dart';
import 'package:shades_cast/main.dart' as app;
import 'package:shades_cast/screens/home/ui/homepage.dart';
import 'package:shades_cast/screens/login_and_signup/ui/login_and_signup.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Tests', () {
    testWidgets(
      'Sign-up test',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.enterText(
            find.byType(RegularTextField).at(0), 'new_user_01');
        await tester.enterText(
            find.byType(RegularTextField).at(1), 'new_user_01@gmail.com');
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

        await tester.enterText(find.byType(RegularTextField).at(0), 'firaol');
        await tester.enterText(find.byType(RegularTextField).at(1), 'admin');

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
}
