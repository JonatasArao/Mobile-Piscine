import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/location.dart';
import '../models/weather.dart';

class WeeklyView extends StatefulWidget {
  const WeeklyView({
    super.key,
    required this.location,
    required this.weekWeather,
  });
  final Location location;
  final List<Weather> weekWeather;

  @override
  State<WeeklyView> createState() => _WeeklyViewState();
}

class _WeeklyViewState extends State<WeeklyView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = widget.location;
    final weekWeather = widget.weekWeather;

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
                        "Weekly temperatures",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 185,
                        child: LineChart(
                          LineChartData(
                            minX: 0,
                            maxX: weekWeather.length.toDouble(),
                            minY: Weather.getMinTemperatureFromList(weekWeather).ceilToDouble() - 2,
                            maxY: Weather.getMaxTemperatureFromList(weekWeather).floorToDouble() + 2,
                            gridData: FlGridData(
                              show: true,
                              drawHorizontalLine: true,
                              drawVerticalLine: true,
                              horizontalInterval: 2,
                              verticalInterval: 1,
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
                                        "${value.toInt()}${weekWeather.first.maxTemperatureUnit}",
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
                                  interval: 0.5,
                                  getTitlesWidget: (value, meta) {
                                    int index = value.toInt();
                                    if (index >= 0 &&
                                        index < weekWeather.length &&
                                        value - 0.5 == index) {
                                      final weather = weekWeather.elementAt(
                                        index,
                                      );
                                      return Text(
                                        weather.date,
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
                                spots: List.generate(weekWeather.length, (
                                  index,
                                ) {
                                  final weather = weekWeather.elementAt(index);
                                  return FlSpot(
                                    index.toDouble() + 0.5,
                                    weather.maxTemperatureValue,
                                  );
                                }),
                                isCurved: false,
                                barWidth: 2,
                                color: Colors.redAccent,
                                dotData: FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) =>
                                          FlDotCirclePainter(
                                            radius: 2,
                                            color: Colors.white,
                                            strokeWidth: 2,
                                            strokeColor: Colors.redAccent,
                                          ),
                                ),
                              ),
                              LineChartBarData(
                                spots: List.generate(weekWeather.length, (
                                  index,
                                ) {
                                  final weather = weekWeather.elementAt(index);
                                  return FlSpot(
                                    index.toDouble() + 0.5,
                                    weather.minTemperatureValue,
                                  );
                                }),
                                isCurved: false,
                                barWidth: 2,
                                color: Colors.blueAccent,
                                dotData: FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) =>
                                          FlDotCirclePainter(
                                            radius: 2,
                                            color: Colors.white,
                                            strokeWidth: 2,
                                            strokeColor: Colors.blueAccent,
                                          ),
                                ),
                              ),
                            ],
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                fitInsideHorizontally: true,
                                getTooltipItems: (touchedSpots) {
                                  return touchedSpots.map((barSpot) {
                                    return LineTooltipItem(
                                      '${barSpot.y}${weekWeather.first.maxTemperatureUnit}',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.commit,
                                    color: Colors.blueAccent,
                                    size: 16,
                                  ),
                                ),
                                const TextSpan(
                                  text: " Min. Temperature",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.commit,
                                    color: Colors.redAccent,
                                    size: 16,
                                  ),
                                ),
                                const TextSpan(
                                  text: " Max. Temperature",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                    itemCount: weekWeather.length,
                    itemBuilder: (context, index) {
                      final weather = weekWeather.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              weather.date,
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
                            const SizedBox(height: 15),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.redAccent,
                                ),
                                children: [
                                  TextSpan(text: weather.maxTemperature),
                                  TextSpan(
                                    text: " max",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueAccent,
                                ),
                                children: [
                                  TextSpan(text: weather.minTemperature),
                                  TextSpan(
                                    text: " min",
                                    style: const TextStyle(fontSize: 13),
                                  ),
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
