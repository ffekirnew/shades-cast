import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/regular_text_field.dart';

void main() {
  testWidgets('RegularTextField displays correctly',
      (WidgetTester tester) async {
    // Build your widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RegularTextField(
            hintText: 'Enter your name',
          ),
        ),
      ),
    );

    // Find the text field widget
    final textFieldWidget = find.byType(TextField);

    // Verify that the text field is displayed correctly
    expect(textFieldWidget, findsOneWidget);
  });

  testWidgets('RegularTextField triggers correct events',
      (WidgetTester tester) async {
    // Create a mock controller for testing
    final controller = TextEditingController();

    // Build your widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RegularTextField(
            hintText: 'Enter your name',
            controller: controller,
          ),
        ),
      ),
    );

    // Find the text field widget
    final textFieldWidget = find.byType(TextField);

    // Enter text in the text field
    await tester.enterText(textFieldWidget, 'John Doe');

    // Verify that the text was entered correctly
    expect(controller.text, equals('John Doe'));
  });

  // Add more widget tests to cover different scenarios
}
