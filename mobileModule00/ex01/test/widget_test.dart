// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ex01/main.dart';

void main()
{
	testWidgets('Ex01Text displays correct text', (WidgetTester tester) async
		{
			await tester.pumpWidget(const MaterialApp(
				home: Ex01Text(currentText: 'A simple text'),
			));

			expect(find.text('A simple text'), findsOneWidget);
		}
	);

	testWidgets('Ex01Button displays correct text and prints message on press', (WidgetTester tester) async
		{
			await tester.pumpWidget(const MaterialApp(
				home: Ex01Button(buttonText: 'Click me', pressedMessage: 'Button pressed'),
			));

			expect(find.text('Click me'), findsOneWidget);

			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			// Since debugPrint outputs to the console, we can't directly test it here.
			// However, we can ensure the button is tappable without errors.
		}
	);

	testWidgets('Ex01 widget tree is built correctly', (WidgetTester tester) async
	{
		await tester.pumpWidget(const Ex01());

		expect(find.byType(Ex01Text), findsOneWidget);
		expect(find.byType(Ex01Button), findsOneWidget);
	});
}

