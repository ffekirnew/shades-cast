import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/regular_text_field.dart';

void main() {
  testWidgets('RegularTextField displays correct icon based on hintText',
      (WidgetTester tester) async {
    // Build your widget
    await tester.pumpWidget(
      MaterialApp(
        home: RegularTextField(
          hintText: 'Enter your name',
        ),
      ),
    );

    // Find the prefixIcon widget
    final prefixIconWidget = find.byIcon(Icons.person);

    // Verify that the correct icon is displayed
    expect(prefixIconWidget, findsOneWidget);
  });

  // Add more unit tests to cover different scenarios
}
