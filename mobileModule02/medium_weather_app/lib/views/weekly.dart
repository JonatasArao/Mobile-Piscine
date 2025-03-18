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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 20,
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Max Temp.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Min Temp.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Wind Speed',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Description',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  rows:
                      weekWeather.map((weather) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                weather.date,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DataCell(
                              Text(
                                weather.maxTemperature,
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
                            DataCell(
                              Text(
                                weather.description,
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
