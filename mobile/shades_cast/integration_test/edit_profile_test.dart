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
      'Edit account settings test',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(Key('home_page_menu_button')));
        await tester.pumpAndSettle();
      },
    );
  });
}
