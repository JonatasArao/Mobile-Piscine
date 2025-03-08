import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ex01/main.dart';

void main() {
	testWidgets('Ex01Text displays correct text', (WidgetTester tester) async {
		await tester.pumpWidget(const MaterialApp(
			home: Ex01Text(currentText: 'A simple text'),
		));

		expect(find.text('A simple text'), findsOneWidget);
	});

	testWidgets('Ex01Button displays correct text and prints message on press', (WidgetTester tester) async {
		await tester.pumpWidget(MaterialApp(
			home: Ex01Button(
				buttonText: 'Click me',
				pressedMessage: 'Button pressed',
				onPressed: () {},
			),
		));

		expect(find.text('Click me'), findsOneWidget);

		await tester.tap(find.byType(ElevatedButton));
		await tester.pump();

		// Since debugPrint outputs to the console, we can't directly test it here.
		// However, we can ensure the button is tappable without errors.
	});

	testWidgets('Ex01 widget tree is built correctly', (WidgetTester tester) async {
		await tester.pumpWidget(const Ex01());

		expect(find.byType(Ex01Text), findsOneWidget);
		expect(find.byType(Ex01Button), findsOneWidget);
	});

	testWidgets('Ex01Text toggles text on button press', (WidgetTester tester) async {
		await tester.pumpWidget(const Ex01());

		expect(find.text('A   simple text'), findsOneWidget);
		expect(find.text('Hello World'), findsNothing);

		await tester.tap(find.byType(ElevatedButton));
		await tester.pump();

		expect(find.text('A   simple text'), findsNothing);
		expect(find.text('Hello World'), findsOneWidget);

		await tester.tap(find.byType(ElevatedButton));
		await tester.pump();

		expect(find.text('A   simple text'), findsOneWidget);
		expect(find.text('Hello World'), findsNothing);
	});

	testWidgets('Ex01Button has correct initial style', (WidgetTester tester) async {
		await tester.pumpWidget(MaterialApp(
			home: Ex01Button(
				buttonText: 'Click me',
				pressedMessage: 'Button pressed',
				onPressed: () {},
			),
		));

		final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
		expect(button.style?.backgroundColor?.resolve({}), Colors.grey[600]);
		expect(button.style?.foregroundColor?.resolve({}), Colors.white);
	});
}

