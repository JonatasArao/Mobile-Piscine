import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/location.dart';
import '../models/weather.dart';

class TodayView extends StatefulWidget {
  const TodayView({
    super.key,
    required this.location,
    required this.todayWeather,
  });
  final Location location;
  final List<Weather> todayWeather;

  @override
  State<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = widget.location;
    final todayWeather = widget.todayWeather;

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
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const Text(
                        "Today temperatures",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            minY:
                                todayWeather
                                    .map(
                                      (weather) => weather.maxTemperatureValue,
                                    )
                                    .reduce((a, b) => a < b ? a : b)
                                    .ceilToDouble() -
                                2,
                            maxY:
                                todayWeather
                                    .map(
                                      (weather) => weather.maxTemperatureValue,
                                    )
                                    .reduce((a, b) => a > b ? a : b)
                                    .floorToDouble() +
                                2,
                            gridData: FlGridData(
                              show: true,
                              drawHorizontalLine: true,
                              drawVerticalLine: true,
                              horizontalInterval: 2,
                              verticalInterval: 3,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: Colors.grey,
                                  strokeWidth: 1,
                                );
                              },
                              getDrawingVerticalLine: (value) {
                                return FlLine(
                                  color: Colors.grey,
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 35,
                                  getTitlesWidget:
                                      (value, meta) => Text(
                                        "${value.toInt()}${todayWeather.first.maxTemperatureUnit}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 3,
                                  getTitlesWidget: (value, meta) {
                                    int index = value.toInt();
                                    if (index >= 0 &&
                                        index < todayWeather.length) {
                                      final weather = todayWeather.elementAt(
                                        index,
                                      );
                                      return Text(
                                        weather.time,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: List.generate(todayWeather.length, (
                                  index,
                                ) {
                                  final weather = todayWeather.elementAt(index);
                                  return FlSpot(
                                    index.toDouble(),
                                    weather.maxTemperatureValue,
                                  );
                                }),
                                isCurved: true,
                                barWidth: 2,
                                color: Colors.teal,
                                dotData: FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) =>
                                          FlDotCirclePainter(
                                            radius: 2,
                                            color: Colors.white,
                                            strokeWidth: 2,
                                            strokeColor: Colors.teal,
                                          ),
                                ),
                              ),
                            ],
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                getTooltipItems: (touchedSpots) {
                                  return touchedSpots.map((barSpot) {
                                    return LineTooltipItem(
                                      '${barSpot.y}${todayWeather.first.maxTemperatureUnit}',
                                      const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(color: Colors.black38),
                height: 175,
                width: MediaQuery.of(context).size.width,
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
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
