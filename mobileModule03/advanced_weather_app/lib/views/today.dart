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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Time',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Temperature',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Wind Speed',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  rows:
                      todayWeather.map((weather) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                weather.time,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DataCell(
                              Text(
                                weather.minTemperature,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DataCell(
                              Text(
                                weather.windSpeed,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
