import 'package:flutter_test/flutter_test.dart';
import 'package:ex02/main.dart';
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

  testWidgets('Calculator button press updates display', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalculatorApp());
    await tester.tap(find.widgetWithText(TextButton, '1'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  });
}
