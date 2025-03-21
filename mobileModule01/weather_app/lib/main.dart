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

class CurrentlyView extends StatelessWidget {
  const CurrentlyView({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Currently',
            style: TextStyle(fontSize: 30, height: 1.5, fontWeight: FontWeight.bold),
          ),
          if (location.isNotEmpty)
            Text(
              location,
              style: TextStyle(fontSize: 30, height: 1),
            ),
        ],
      ),
    );
  }
}

class TodayView extends StatelessWidget {
  const TodayView({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Today',
            style: TextStyle(fontSize: 30, height: 1.5, fontWeight: FontWeight.bold),
          ),
          if (location.isNotEmpty)
            Text(
              location,
              style: TextStyle(fontSize: 30, height: 1),
            ),
        ],
      ),
    );
  }
}

class WeeklyView extends StatelessWidget {
  const WeeklyView({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Weekly',
            style: TextStyle(fontSize: 30, height: 1.5, fontWeight: FontWeight.bold),
          ),
          if (location.isNotEmpty)
            Text(
              location,
              style: TextStyle(fontSize: 30, height: 1),
            ),
        ],
      ),
    );
  }
}

class _ScreenState extends State<Screen> {
  String _location = '';

  void _updateLocation(String location) {
    setState(() {
      _location = location;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search Location...',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
            onSubmitted: (value) => _updateLocation(value),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            SizedBox(
              width: 1,
              height: 30,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: const Icon(Icons.near_me),
                onPressed: () => _updateLocation('Geolocation'),
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            CurrentlyView(location: _location),
            TodayView(location: _location),
            WeeklyView(location: _location),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.zero,
          color: Colors.grey[900],
          child: TabBar(
            indicatorColor: Colors.tealAccent,
            indicator: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.tealAccent, width: 2.0),
              ),
            ),
            labelColor: Colors.tealAccent,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(icon: Icon(Icons.thermostat, size: 25), text: 'Currently'),
              Tab(icon: Icon(Icons.today, size: 25), text: 'Today'),
              Tab(icon: Icon(Icons.date_range, size: 25), text: 'Weekly'),
            ],
          ),
        ),
      ),
    );
  }
}
