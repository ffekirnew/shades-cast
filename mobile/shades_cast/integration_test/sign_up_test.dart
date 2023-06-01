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
      'sign up test',
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
  });
}
