import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/regular_text_field.dart';
import 'package:shades_cast/main.dart' as app;
import 'package:shades_cast/screens/home/ui/homepage.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('login test', () {
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
  });
}
