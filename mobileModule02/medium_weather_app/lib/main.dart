import 'package:flutter/material.dart';
import 'models/location.dart';
import 'views/currently.dart';
import 'views/today.dart';
import 'views/weekly.dart';

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
  late Iterable<Location> searchList;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    location = Location.fetchGeolocation();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Autocomplete<Location>(
            optionsBuilder: (TextEditingValue textEditingValue) async {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<Location>.empty();
              }
              try {
                searchList = await Location.fetchLocations(
                  textEditingValue.text,
                );
              } catch (e) {
                searchList = const Iterable<Location>.empty();
              }
              return searchList;
            },
            displayStringForOption: (Location option) {
              String displayString = option.name;
              return displayString;
            },
            optionsViewBuilder: (
              BuildContext context,
              AutocompleteOnSelected<Location> onSelected,
              Iterable<Location> options,
            ) {
              return Container(
                color: Theme.of(context).colorScheme.surface,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Location option = options.elementAt(index);
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.tealAccent),
                        ),
                      ),
                      child: ListTile(
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: option.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              if (option.region?.isNotEmpty == true)
                                TextSpan(
                                  text: ' ${option.region}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              if (option.country?.isNotEmpty == true)
                                TextSpan(
                                  text: ', ${option.country}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                            ],
                          ),
                        ),
                        onTap: () {
                          onSelected(option);
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    );
                  },
                ),
              );
            },
            fieldViewBuilder: (
              BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted,
            ) {
              searchController = textEditingController;
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Location...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
                onSubmitted: (value) async {
                  if (value.isEmpty) return;
                  if (searchList.isNotEmpty) {
                    onFieldSubmitted();
                  } else {
                    try {
                      searchList = await Location.fetchLocations(value);
                      setState(() {
                        location = Future.value(searchList.first);
                      });
                    } catch (e) {
                      setState(() {
                        location = Future.error(e.toString());
                      });
                    }
                  }
                },
              );
            },
            onSelected: (Location selection) {
              setState(() {
                location = Future.value(selection);
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
                    searchController.clear();
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
