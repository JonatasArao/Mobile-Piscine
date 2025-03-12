import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
  final Map<String, String?> location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (location['error'] == null) ...[
            Text(
              'Currently',
              style: TextStyle(
                fontSize: 30,
                height: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (location['latitude'] != null && location['longitude'] != null)
              Text(
                '${location['latitude']} ${location['longitude']}',
                style: TextStyle(fontSize: 30, height: 1),
              ),
          ] else
            Text(
              '${location['error']}',
              style: TextStyle(fontSize: 18, height: 1, color: Colors.red),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}

class TodayView extends StatelessWidget {
  const TodayView({super.key, required this.location});
  final Map<String, String?> location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (location['error'] == null) ...[
            Text(
              'Today',
              style: TextStyle(
                fontSize: 30,
                height: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (location['latitude'] != null && location['longitude'] != null)
              Text(
                '${location['latitude']} ${location['longitude']}',
                style: TextStyle(fontSize: 30, height: 1),
              ),
          ] else
            Text(
              '${location['error']}',
              style: TextStyle(fontSize: 18, height: 1, color: Colors.red),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}

class WeeklyView extends StatelessWidget {
  const WeeklyView({super.key, required this.location});
  final Map<String, String?> location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (location['error'] == null) ...[
            Text(
              'Weekly',
              style: TextStyle(
                fontSize: 30,
                height: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (location['latitude'] != null && location['longitude'] != null)
              Text(
                '${location['latitude']} ${location['longitude']}',
                style: TextStyle(fontSize: 30, height: 1),
              ),
          ] else
            Text(
              '${location['error']}',
              style: TextStyle(fontSize: 18, height: 1, color: Colors.red),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}

class _ScreenState extends State<Screen> {
  Map<String, String?> location = {
    'latitude': null,
    'longitude': null,
    'error': null,
  };

  Future<Position> _getUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Geolocation is not available, please enable it.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return Future.error(
          'Geolocation is not available, location permissions are denied',
        );
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _setUserLocation();
  }

  void _setUserLocation() async {
    try {
      Position position = await _getUserPosition();
      setState(() {
        location['latitude'] = position.latitude.toString();
        location['longitude'] = position.longitude.toString();
        location['error'] = null;
      });
    } catch (e) {
      setState(() {
        location['latitude'] = null;
        location['longitude'] = null;
        location['error'] = e.toString();
      });
    }
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
            style: const TextStyle(color: Colors.white, fontSize: 18),
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
                onPressed: () => _setUserLocation(),
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            CurrentlyView(location: location),
            TodayView(location: location),
            WeeklyView(location: location),
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
