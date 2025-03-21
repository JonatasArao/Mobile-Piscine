import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/home.dart';
import 'views/login.dart';
import 'views/dash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiaryApp',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          onPrimary: Colors.white,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.outfitTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[900],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            textStyle: GoogleFonts.outfit(fontSize: 20),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
        '/login': (context) => const LoginView(),
        '/dash': (context) => const DashView(),
      },
    );
  }
}
