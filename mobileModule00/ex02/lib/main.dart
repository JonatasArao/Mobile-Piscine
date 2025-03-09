import 'package:flutter/material.dart';

void main() {
	runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
	const CalculatorApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Calculator App',
			theme: ThemeData(
				colorScheme: ColorScheme.fromSeed(
					seedColor: Colors.blueGrey,
					brightness: Brightness.dark,
				),
			),
			home: const Screen(title: 'Calculator'),
		);
	}
}

class CalculatorButton extends StatelessWidget {
	const CalculatorButton({
		super.key,
		required this.buttonText,
		required this.textColor,
	});
	final String buttonText;
	final Color textColor;

	@override
	Widget build(BuildContext context) {
		final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
		double padding;
		double fontSize;

		if (isPortrait)
		{
			padding = 15;
			fontSize = 30;
		}
		else
		{
			padding = 10;
			fontSize = 20;
		}
		return TextButton(
			style: TextButton.styleFrom(
				padding: EdgeInsets.all(padding),
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.zero,
				),
			),
			onPressed: () => debugPrint(buttonText),
			child: Text(
				buttonText,
				style: TextStyle(
					fontSize: fontSize,
					color: textColor,
				),
			),
		);
	}
}

class Screen extends StatefulWidget {
	const Screen({super.key, required this.title});
	final String title;

	@override
	State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
	final TextEditingController _expression = TextEditingController(text: '0');
	final TextEditingController _value = TextEditingController(text: '0');

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Theme.of(context).colorScheme.inversePrimary,
				title: Text(widget.title),
				centerTitle: true,
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.end,
					children: [
						TextField(
							controller: _expression,
							decoration: InputDecoration(
								enabled: false,
								border: InputBorder.none,
			 					contentPadding: EdgeInsets.only(right: 16.0), 
							),
							textAlign: TextAlign.right,
							style: TextStyle(
									color: Colors.white,
									fontSize: 30,
							),
						),
						TextField(
							controller: _value,
							decoration: InputDecoration(
								enabled: false,
								border: InputBorder.none,
			 					contentPadding: EdgeInsets.only(right: 16.0), 
							),
							textAlign: TextAlign.right,
							style: TextStyle(
									color: Colors.white,
									fontSize: 30,
							),
						),
						Spacer(),
						Container(
							color: Colors.blueGrey,
							child: Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Expanded(
										child: CalculatorButton(
											buttonText: "7",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "8",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "9",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "C",
											textColor: Colors.red[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "AC",
											textColor: Colors.red[900]!,
										),
									),
								],
							),
						),
						Container(
							color: Colors.blueGrey,
							child: Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Expanded(
										child: CalculatorButton(
											buttonText: "4",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "5",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "6",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "+",
											textColor: Colors.white,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "-",
											textColor: Colors.white,
										),
									),
								],
							),
						),
						Container(
							color: Colors.blueGrey,
							child: Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Expanded(
										child: CalculatorButton(
											buttonText: "1",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "2",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "3",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "x",
											textColor: Colors.white,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "/",
											textColor: Colors.white,
										),
									),
								],
							),
						),
						Container(
							color: Colors.blueGrey,
							child: Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Expanded(
										child: CalculatorButton(
											buttonText: "0",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: ".",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "00",
											textColor: Colors.blueGrey[900]!,
										),
									),
									Expanded(
										child: CalculatorButton(
											buttonText: "=",
											textColor: Colors.white,
										),
									),
									Expanded(child: Container()),
								],
							),
						),
					],
				),
			),
		);
	}
}