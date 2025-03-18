import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/weather.dart';

class WeeklyView extends StatelessWidget {
  const WeeklyView({
    super.key,
    required this.location,
    required this.weekWeather,
  });
  final Location location;
  final List<Weather> weekWeather;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
            Padding(
            padding: const EdgeInsets.all(2),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
              style: TextStyle(fontSize: 20, color: Colors.white),
              text: location.name,
              children: [
                if (location.region.isNotEmpty)
                TextSpan(text: "\n${location.region}"),
                if (location.country.isNotEmpty)
                TextSpan(text: "\n${location.country}"),
              ],
              ),
            ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: weekWeather.length,
              itemBuilder: (context, index) {
                final weather = weekWeather[index];
                return Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    Text(weather.date, style: TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.center),
                    Text(
                      weather.maxTemperature,
                      style: TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.center,
                    ),
                    Text(
                      weather.minTemperature,
                      style: TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.center,
                    ),
                    Text(
                      weather.windSpeed,
                      style: TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.center,
                    ),
                    Text(
                      weather.description,
                      style: TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
