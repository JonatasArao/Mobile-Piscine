import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
    required this.action,
  });
  final String buttonText;
  final void Function(String) action;

  double _getPadding(BuildContext context) {
    final Orientation orientation;

    orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return (15);
    }
    return (10);
  }

  double _getFontSize(BuildContext context) {
    final Orientation orientation;

    orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return (30);
    }
    return (20);
  }

  Color _getTextColor(BuildContext context) {
    final Map<String, Color> buttonColorMap;

    buttonColorMap = {
      '=': Colors.white,
      '+': Colors.white,
      '-': Colors.white,
      'x': Colors.white,
      '/': Colors.white,
      'C': Colors.red[900]!,
      'AC': Colors.red[900]!,
    };
    if (buttonColorMap[buttonText] != null) {
      return (buttonColorMap[buttonText]!);
    }
    return (Colors.blueGrey[900]!);
  }

  @override
  Widget build(BuildContext context) {
    final double padding = _getPadding(context);
    final double fontSize = _getFontSize(context);
    final Color textColor = _getTextColor(context);
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(padding),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        onPressed: () {
          debugPrint(buttonText);
          action(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: fontSize, color: textColor),
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
  final TextEditingController _result = TextEditingController(text: '0');

  void _cleanExpression() {
    _expression.text = '0';
    _result.text = '0';
  }

  void _deleteLastExpressionChar() {
    String expression;
    int len;

    expression = _expression.text;
    len = expression.length;
    if (expression.isNotEmpty && len > 1) {
      expression = expression.substring(0, len - 1);
    } else {
      expression = '0';
    }
    _expression.text = expression;
  }

  String _getLastNumber(String expression) {
    int lastOpIndex;
    String lastNumber;

    lastOpIndex = expression.lastIndexOf(RegExp(r'[+\-x/]'));
    if (lastOpIndex == -1) {
      lastNumber = expression;
    } else {
      lastNumber = expression.substring(lastOpIndex + 1);
    }
    return (lastNumber);
  }

  bool _isLastNumberDecimal(String expression) {
    String lastNumber;

    lastNumber = _getLastNumber(expression);
    return (lastNumber.contains("."));
  }

  bool _isLastNumberLeadingZero(String expression) {
    String lastNumber;

    lastNumber = _getLastNumber(expression);
    return (lastNumber == '0');
  }

  bool _isDuplicateOperator(String expression, String buttonText) {
    if (['+', 'x', '/'].contains(buttonText) &&
            expression.endsWith(buttonText) ||
        expression == '-' && buttonText == '-') {
      return (true);
    }
    return (false);
  }

  String _addExpressionOperator(String expression, String buttonText) {
    if (_isDuplicateOperator(expression, buttonText)) {
      return (expression);
    }
    if ((['+', 'x', '/'].contains(buttonText) && expression == '-')) {
      expression = '0';
    } else if ((expression.endsWith('x-') ||
            expression.endsWith('/-') ||
            expression.endsWith('x+') ||
            expression.endsWith('/+') ||
            expression.endsWith('--') ||
            expression.endsWith('+-') ||
            expression.endsWith('-+')) &&
        ['x', '/'].contains(buttonText)) {
      expression = expression.substring(0, expression.length - 2) + buttonText;
    } else if (((expression.endsWith('+') ||
                expression.endsWith('-') ||
                expression.endsWith('x') ||
                expression.endsWith('/')) &&
            ['x', '/'].contains(buttonText)) ||
        ((expression.endsWith('x-') ||
                expression.endsWith('/-') ||
                expression.endsWith('x+') ||
                expression.endsWith('/+') ||
                expression.endsWith('--') ||
                expression.endsWith('+-') ||
                expression.endsWith('-+')) &&
            ['+', '-'].contains(buttonText))) {
      expression = expression.substring(0, expression.length - 1) + buttonText;
    } else if (expression == '0' && buttonText == '-') {
      expression = buttonText;
    } else {
      expression += buttonText;
    }
    return (expression);
  }

  String _addExpressionDecimalPoint(String expression, String buttonText) {
    if (buttonText == "." && _isLastNumberDecimal(expression)) {
      return (expression);
    }
    if ((expression.endsWith('+') ||
        expression.endsWith('-') ||
        expression.endsWith('x') ||
        expression.endsWith('/'))) {
      expression = '${expression}0$buttonText';
    } else {
      expression += buttonText;
    }
    return (expression);
  }

  String _addExpressionDoubleZero(String expression, String buttonText) {
    if (['00', '0'].contains(buttonText) &&
        _isLastNumberLeadingZero(expression)) {
      return (expression);
    }
    if ((expression.endsWith('+') ||
        expression.endsWith('-') ||
        expression.endsWith('x') ||
        expression.endsWith('/'))) {
      expression = '${expression}0';
    } else {
      expression += buttonText;
    }
    return (expression);
  }

  String _addExpressionNumber(String expression, String buttonText) {
    if (expression == '0' ||
        expression.endsWith('+0') ||
        expression.endsWith('-0') ||
        expression.endsWith('x0') ||
        expression.endsWith('/0')) {
      expression = expression.substring(0, expression.length - 1) + buttonText;
    } else {
      expression += buttonText;
    }
    return (expression);
  }

  void _addExpressionText(String buttonText) {
    String expression;

    expression = _expression.text;
    switch (buttonText) {
      case '+':
      case '-':
      case 'x':
      case '/':
        expression = _addExpressionOperator(expression, buttonText);
        break;
      case '.':
        expression = _addExpressionDecimalPoint(expression, buttonText);
        break;
      case '00':
        expression = _addExpressionDoubleZero(expression, buttonText);
        break;
      default:
        expression = _addExpressionNumber(expression, buttonText);
        break;
    }
    _expression.text = expression;
  }

  void _calcExpression() {
    String expression;
    String result;

    expression = _expression.text
        .replaceAll('0.+', '0+')
        .replaceAll('0.-', '0-')
        .replaceAll('0.x', '0x')
        .replaceAll('0./', '/');
    if (expression.endsWith('0.')) {
      expression = expression.substring(0, expression.length - 1);
    }
    _expression.text = expression;
    expression = expression.replaceAll('x', '*');
    try {
      GrammarParser p = GrammarParser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      result = eval.toString();
      if (result.endsWith('.0')) {
        result = result.substring(0, result.length - 2);
      }
    } catch (e) {
      result = 'Error';
    }
    _result.text = result;
  }

  void _buttonAction(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'AC':
          _cleanExpression();
          break;
        case 'C':
          _deleteLastExpressionChar();
          break;
        case '=':
          _calcExpression();
          break;
        default:
          _addExpressionText(buttonText);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
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
            textDirection: TextDirection.ltr,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          TextField(
            controller: _result,
            decoration: const InputDecoration(
              enabled: false,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(right: 16.0),
            ),
            textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.white, fontSize: 30),
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
    );
  }
}
