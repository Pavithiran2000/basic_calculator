import 'package:basic_calculator/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Calculator App Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    // Verify that the app title is displayed on the app bar.
    expect(find.text('BASIC FUNCTION CALCULATOR'), findsOneWidget);

    // Verify that the initial display text is empty.
    expect(find.text(''), findsOneWidget);

    // Tap some buttons on the calculator.
    await tapButton(tester, '1');
    await tapButton(tester, '+');
    await tapButton(tester, '2');
    await tapButton(tester, 'Enter');

    // Verify that the result is displayed as '3'.
    expect(find.text('3'), findsOneWidget);

    // Clear the input.
    await tapButton(tester, 'C');

    // Verify that the display text is empty again.
    expect(find.text(''), findsOneWidget);
  });
}

// Helper function to tap a button on the calculator app.
Future<void> tapButton(WidgetTester tester, String buttonText) async {
  await tester.tap(find.widgetWithText(ElevatedButton, buttonText));
  await tester.pump();
}
