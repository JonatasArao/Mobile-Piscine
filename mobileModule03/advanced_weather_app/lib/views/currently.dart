import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/weather.dart';

class CurrentlyView extends StatelessWidget {
  const CurrentlyView({
    super.key,
    required this.location,
    required this.currentWeather,
  });
  final Location location;
  final Weather currentWeather;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(fontSize: 25, color: Colors.white),
              text: location.name,
              children: [
                if (location.region.isNotEmpty)
                  TextSpan(text: "\n${location.region}"),
                if (location.country.isNotEmpty)
                  TextSpan(text: "\n${location.country}"),
                TextSpan(text: "\n${currentWeather.maxTemperature}"),
                TextSpan(text: "\n${currentWeather.windSpeed}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
