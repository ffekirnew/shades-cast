import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/result_showing_bar.dart';

void main() {
  testWidgets('ResultShowingBar displays success message for signup',
      (WidgetTester tester) async {
    // Build your widget
    await tester.pumpWidget(
      MaterialApp(
        home: ResultShowingBar(
          state: ResultShowingState(
            successNote: true,
            failureNote: '',
            isLoading: false,
          ),
          isSignup: true,
        ),
      ),
    );

    // Find the success message widget
    final successMessageWidget =
        find.text("Signup was successfull. Log in to get started.");

    // Verify that the success message is displayed
    expect(successMessageWidget, findsOneWidget);
  });

  // Add more unit tests to cover different scenarios
}

class ResultShowingState {
  final bool successNote;
  final String failureNote;
  final bool isLoading;

  ResultShowingState({
    required this.successNote,
    required this.failureNote,
    required this.isLoading,
  });
}
