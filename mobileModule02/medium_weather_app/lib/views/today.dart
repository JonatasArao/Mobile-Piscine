import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/weather.dart';

class TodayView extends StatelessWidget {
  const TodayView({
    super.key,
    required this.location,
    required this.todayWeather,
  });
  final Location location;
  final List<Weather> todayWeather;

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
              itemCount: todayWeather.length,
              itemBuilder: (context, index) {
                final weather = todayWeather[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(weather.time, style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center),
                    Text(
                      weather.maxTemperature,
                      style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center,
                    ),
                    Text(
                      weather.windSpeed,
                      style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center,
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
