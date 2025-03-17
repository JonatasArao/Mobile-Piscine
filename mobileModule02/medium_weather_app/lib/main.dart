import 'package:flutter/material.dart';
import 'models/location.dart';
import 'views/currently.dart';
import 'views/today.dart';
import 'views/weekly.dart';
import 'widgets/location_search.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          onPrimary: Colors.teal[900]!,
          primary: Colors.tealAccent,
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
  late Future<Location> location;
  final GlobalKey<LocationSearchState> _locationSearchKey = GlobalKey<LocationSearchState>();

  @override
  void initState() {
    super.initState();
    location = Location.fetchGeolocation();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: LocationSearch(
            key: _locationSearchKey,
            onSearchSuccess: (Location result) {
              setState(() {
                location = Future.value(result);
              });
            },
            onSearchError: (String error) {
              setState(() {
                location = Future.error(error);
              });
            },
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
                onPressed: () {
                  setState(() {
                    location = Location.fetchGeolocation();
                    _locationSearchKey.currentState?.clear();
                  });
                },
              ),
            ),
          ],
        ),
        body: FutureBuilder<Location>(
          future: location,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.tealAccent),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              final location = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: TabBarView(
                  children: [
                    CurrentlyView(location: location),
                    TodayView(location: location),
                    WeeklyView(location: location),
                  ],
                ),
              );
            } else {
              return Center(child: Text('Unknown error occurred'));
            }
          },
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
