import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';

class DashView extends StatefulWidget {
  const DashView({super.key});
  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  final Auth authInstance = Auth();
  User? user;

  @override
  void initState() {
    super.initState();
    user = authInstance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (user != null)
              Text(
                'Hello, ${user!.displayName ?? 'User'}!',
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
