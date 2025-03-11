import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          onPrimary: Colors.teal[900]!,
          brightness: Brightness.dark,
        ),
      ),
      home: const Screen(),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Weather"),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Currently', style: TextStyle(fontSize: 30))),
            Center(child: Text('Today', style: TextStyle(fontSize: 30))),
            Center(child: Text('Weekly', style: TextStyle(fontSize: 30))),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            indicatorColor: Colors.tealAccent,
            indicator: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.tealAccent, width: 2.0),
              ),
            ),
            labelPadding: EdgeInsets.only(top: 8.0),
            labelColor: Colors.tealAccent,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(icon: Icon(Icons.thermostat, size: 20), text: 'Currently'),
              Tab(icon: Icon(Icons.today, size: 20), text: 'Today'),
              Tab(icon: Icon(Icons.date_range, size: 20), text: 'Weekly'),
            ],
          ),
        ),
      ),
    );
  }
}
