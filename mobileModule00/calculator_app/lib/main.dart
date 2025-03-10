import 'package:flutter/material.dart';

void main()
{
	runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget
{
	const CalculatorApp({super.key});

	@override
	Widget build(BuildContext context)
	{
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

class CalculatorButton extends StatelessWidget
{
	CalculatorButton({
		super.key,
		required this.buttonText,
		required this.action,
	});
	final String buttonText;
	final void Function(String) action;

	@override
	Widget build(BuildContext context)
	{
		final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
		double padding;
		double fontSize;
		Color textColor;

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
		if (buttonText == '=' || buttonText == '+' || buttonText == '-'
					|| buttonText == 'x' || buttonText == '/')
		{
			textColor = Colors.white;
		}
		else if (buttonText == 'C' || buttonText == 'AC')
		{
			textColor = Colors.red[900]!;
		}
		else
		{
			textColor = Colors.blueGrey[900]!;
		}
		return Expanded(
			child: TextButton(
				style: TextButton.styleFrom(
					padding: EdgeInsets.all(padding),
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.zero,
					),
				),
				onPressed: ()
				{
					debugPrint(buttonText);
					action(buttonText);
				},
				child: Text(
					buttonText,
					style: TextStyle(
						fontSize: fontSize,
						color: textColor,
					),
				),
			),
		);
	}
}

class Screen extends StatefulWidget
{
	const Screen({super.key, required this.title});
	final String title;

	@override
	State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen>
{
	final TextEditingController _expression = TextEditingController(text: '0');
	final TextEditingController _result = TextEditingController(text: '0');

	void _buttonAction(String buttonText)
	{
			setState(()
			{
				String expressionText = _expression.text;
				String resultText = _result.text;

				if (buttonText == 'AC')
				{
						expressionText = '0';
						resultText = '0';
				}
				else if (buttonText == 'C')
				{
						if (expressionText.isNotEmpty && expressionText.length > 1)
						{
							expressionText = expressionText.substring(0, expressionText.length - 1);
						}
						else
						{
							expressionText = '0';
						}
				}
				else
				{
						if (expressionText == '0')
						{
								expressionText = buttonText;
						}
						else
						{
								expressionText += buttonText;
						}
				}

				_expression.text = expressionText;
				_result.text = resultText;
		});
	}

	@override
	Widget build(BuildContext context)
	{
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
							decoration: const InputDecoration(
							enabled: false,
							border: InputBorder.none,
							contentPadding: EdgeInsets.only(right: 16.0),
							),
							textAlign: TextAlign.right,
							style: const TextStyle(
							color: Colors.white,
							fontSize: 30,
							),
						),
						TextField(
							controller: _result,
							decoration: const InputDecoration(
							enabled: false,
							border: InputBorder.none,
							contentPadding: EdgeInsets.only(right: 16.0),
							),
							textAlign: TextAlign.right,
							style: const TextStyle(
							color: Colors.white,
							fontSize: 30,
							),
						),
						const Spacer(),
						Container(
							color: Colors.blueGrey,
							child: Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
									CalculatorButton(buttonText: "7", action: _buttonAction),
									CalculatorButton(buttonText: "8", action: _buttonAction),
									CalculatorButton(buttonText: "9", action: _buttonAction),
									CalculatorButton(buttonText: "C", action: _buttonAction),
									CalculatorButton(buttonText: "AC", action: _buttonAction),
								],
							),
						),
						Container(
							color: Colors.blueGrey,
							child: Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
									CalculatorButton(buttonText: "4", action: _buttonAction),
									CalculatorButton(buttonText: "5", action: _buttonAction),
									CalculatorButton(buttonText: "6", action: _buttonAction),
									CalculatorButton(buttonText: "+", action: _buttonAction),
									CalculatorButton(buttonText: "-", action: _buttonAction),
								],
							),
						),
						Container(
							color: Colors.blueGrey,
							child: Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
									CalculatorButton(buttonText: "1", action: _buttonAction),
									CalculatorButton(buttonText: "2", action: _buttonAction),
									CalculatorButton(buttonText: "3", action: _buttonAction),
									CalculatorButton(buttonText: "x", action: _buttonAction),
									CalculatorButton(buttonText: "/", action: _buttonAction),
								],
							),
						),
						Container(
							color: Colors.blueGrey,
							child: Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
									CalculatorButton(buttonText: "0", action: _buttonAction),
									CalculatorButton(buttonText: ".", action: _buttonAction),
									CalculatorButton(buttonText: "00", action: _buttonAction),
									CalculatorButton(buttonText: "=", action: _buttonAction),
									const Expanded(child: SizedBox()),
								],
							),
						),
					],
				),
			),
		);
	}
}
