import 'package:diary_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Let's go!",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Sign in to your DiaryApp account',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () async {
                 try {
                   final auth = Auth();
                   await auth.signInWithGoogle();
                 } catch (e) {
                   if (mounted) {
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('GitHub Sign-In failed: $e')),
                     );
                   }
                 }
              },
              icon: const FaIcon(FontAwesomeIcons.google, size: 20),
              label: const Text('Continue with Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () async {
                 try {
                   final auth = Auth();
                   await auth.signInWithGitHub();
                 } catch (e) {
                   if (mounted) {
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('GitHub Sign-In failed: $e')),
                     );
                   }
                 }
              },
              icon: const FaIcon(
                FontAwesomeIcons.github,
                color: Colors.black,
                size: 20,
              ),

              label: const Text('Continue with Github'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
