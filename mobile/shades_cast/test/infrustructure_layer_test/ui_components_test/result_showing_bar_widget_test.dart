import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/result_showing_bar.dart';

void main() {
  testWidgets('ResultShowingBar displays correctly',
      (WidgetTester tester) async {
    // Build your widget
    await tester.pumpWidget(
      MaterialApp(
        home: ResultShowingBar(
          state: ResultShowingState(
            successNote: false,
            failureNote: '',
            isLoading: false,
          ),
          isSignup: false,
        ),
      ),
    );

    // Find the container widget
    final containerWidget = find.byType(Container);

    // Verify that the container is displayed correctly
    expect(containerWidget, findsOneWidget);
  });

  // Add more widget tests to cover different scenarios
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
