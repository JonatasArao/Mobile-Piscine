import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Calculator app has a title', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());
    expect(find.text('Calculator'), findsOneWidget);
  });

  testWidgets('Calculator app has buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());
    expect(find.widgetWithText(TextButton, '7'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '8'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '9'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'C'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'AC'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '4'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '5'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '6'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '+'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '-'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '1'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '2'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '3'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'x'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '/'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '0'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '.'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '00'), findsOneWidget);
    expect(find.widgetWithText(TextButton, '='), findsOneWidget);
  });
}
