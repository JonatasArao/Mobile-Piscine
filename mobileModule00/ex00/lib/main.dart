import 'package:flutter/material.dart';

class Ex00Text extends StatelessWidget {
  const Ex00Text({super.key, required this.currentText});
  final String currentText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.red[900],
        border: Border.all(color: Colors.transparent, width: 2),
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

class Ex00Button extends StatelessWidget {
  const Ex00Button({
    super.key,
    required this.buttonText,
    required this.pressedMessage,
  });
  final String buttonText;
  final String pressedMessage;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[600],
        foregroundColor: Colors.white,
      ),
      onPressed: () => debugPrint(pressedMessage),
      child: Text(buttonText),
    );
  }
}

class Ex00 extends StatelessWidget {
  const Ex00({super.key});

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
                  Ex00Text(currentText: "A   simple text"),
                  Ex00Button(
                    buttonText: "Click me",
                    pressedMessage: "Button pressed",
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
  runApp(const Ex00());
}
