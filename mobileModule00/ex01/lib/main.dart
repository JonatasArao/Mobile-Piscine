import 'package:flutter/material.dart';

class Ex01Text extends StatelessWidget {
	const Ex01Text({super.key, required this.currentText});
	final String currentText;

	@override
	Widget build(BuildContext context) {
		return Container(
			margin: const EdgeInsets.all(10),
			padding: const EdgeInsets.all(5),
			decoration: BoxDecoration(
				color: Colors.red[900],
				border: Border.all(
					color: Colors.transparent,
					width: 2,
				),
				borderRadius: BorderRadius.circular(10),
			),
			child: Text(
				currentText,
				style: TextStyle(
					color: Colors.white,
					fontSize: 30,
					fontWeight: FontWeight.bold,
				),
			),
		);
	}
}

class Ex01Button extends StatelessWidget {
	const Ex01Button({
		super.key,
		required this.buttonText,
		required this.pressedMessage,
		required this.onPressed,
	});
	final String buttonText;
	final String pressedMessage;
	final VoidCallback onPressed;

	@override
	Widget build(BuildContext context) {
		return ElevatedButton(
			style: ElevatedButton.styleFrom(
				backgroundColor: Colors.grey[600],
				foregroundColor: Colors.white,
			),
			onPressed: onPressed,
			child: Text(buttonText),
		);
	}
}

class Ex01 extends StatefulWidget {
	const Ex01({super.key});

	@override
	Ex01State createState() => Ex01State();
}

class Ex01State extends State<Ex01> {
	String currentText = "A   simple text";

	void _toggleCurrentText() {
		setState(() {
			if (currentText == "A   simple text")
			{
				currentText = "Hello World";
			}
			else if (currentText == "Hello World")
			{
				currentText = "A   simple text";
			}
		});
	}

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: Scaffold(
				backgroundColor: Colors.grey[900],
				body: Center(
					child: Builder(
						builder: (context) {
							return Column(
								mainAxisAlignment: MainAxisAlignment.center,
								crossAxisAlignment: CrossAxisAlignment.center,
								children: [
									Ex01Text(currentText: currentText),
									Ex01Button(
										buttonText: "Click me",
										pressedMessage: "Button pressed",
										onPressed: () => _toggleCurrentText(),
									),
								],
							);
						},
					),
				),
			),
		);
	}
}

void main() {
	runApp(const Ex01());
}