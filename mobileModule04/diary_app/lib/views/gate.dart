import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'login.dart';
import 'dash.dart';

class Gate extends StatefulWidget {
  const Gate({super.key});

  @override
  GateState createState() => GateState();
}

class GateState extends State<Gate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DashView();
        } else {
          return const LoginView();
        }
      }
    );
  }
}
