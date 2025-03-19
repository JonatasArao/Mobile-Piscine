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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  children: [
                    TextSpan(
                      text: "${location.name}\n",
                      style: const TextStyle(color: Colors.tealAccent),
                    ),
                    if (location.region.isNotEmpty)
                      TextSpan(text: "${location.region}, "),
                    TextSpan(text: location.country),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Text(
                currentWeather.maxTemperature,
                style: const TextStyle(fontSize: 40, color: Colors.greenAccent),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    currentWeather.description,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Icon(currentWeather.icon, size: 75, color: Colors.tealAccent),
                ],
              ),
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.air,
                        size: 18,
                        color: Colors.tealAccent,
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 5)),
                    TextSpan(text: currentWeather.windSpeed),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
