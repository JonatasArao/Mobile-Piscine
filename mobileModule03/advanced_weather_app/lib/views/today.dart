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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Container(
                decoration: BoxDecoration(color: Colors.black54),
                height: 175,
                width: MediaQuery.of(context).size.width,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: todayWeather.length,
                    itemBuilder: (context, index) {
                      final weather = todayWeather.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              weather.time,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Icon(
                              weather.icon,
                              size: 35,
                              color: Colors.tealAccent,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              weather.maxTemperature,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.greenAccent,
                              ),
                            ),
                            const SizedBox(height: 10),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.air,
                                      size: 14,
                                      color: Colors.tealAccent,
                                    ),
                                  ),
                                  const WidgetSpan(child: SizedBox(width: 5)),
                                  TextSpan(text: weather.windSpeed),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
