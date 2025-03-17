import 'package:http/http.dart' as http;
import 'dart:convert';
import 'exceptions.dart';
import 'dart:io';
import 'location.dart';
import 'weather.dart';

class Report {
  Location location;
  Weather currentWeather;
  List<Weather> todayWeather;
  List<Weather> weekWeather;

  Report._({
    required this.location,
    required this.currentWeather,
    required this.todayWeather,
    required this.weekWeather,
  });

  factory Report._fromJson(Location location, Map<String, dynamic> json) {
    try {
      final currentWeather = _parseCurrentWeather(json['current']);
      final todayWeather = _parseTodayWeather(json['hourly']);
      final weekWeather = _parseWeekWeather(json['daily']);

      return Report._(
        location: location,
        currentWeather: currentWeather,
        todayWeather: todayWeather,
        weekWeather: weekWeather,
      );
    } catch (e) {
      throw APIConnectionException();
    }
  }

  static Weather _parseCurrentWeather(Map<String, dynamic> currentData) {
    final currentJson = {
      'time': currentData['time'] as String,
      'windSpeed': currentData['wind_speed_10m'] as double,
      'maxTemperature': currentData['temperature_2m'] as double,
      'minTemperature': currentData['temperature_2m'] as double,
      'wmoCode': currentData['weather_code'] as int,
    };
    return Weather.fromJson(currentJson);
  }

  static List<Weather> _parseTodayWeather(Map<String, dynamic> hourlyData) {
    final List<dynamic> times = hourlyData['time'];
    final List<dynamic> temperatures = hourlyData['temperature_2m'];
    final List<dynamic> windSpeeds = hourlyData['wind_speed_10m'];
    final List<dynamic> wmoCodes = hourlyData['weather_code'];

    return List.generate(
      times.length,
      (i) => Weather.fromJson({
        'time': times[i] as String,
        'windSpeed': windSpeeds[i] as double,
        'maxTemperature': temperatures[i] as double,
        'minTemperature': temperatures[i] as double,
        'wmoCode': wmoCodes[i] as int,
      }),
    );
  }

  static List<Weather> _parseWeekWeather(Map<String, dynamic> dailyData) {
    final List<dynamic> times = dailyData['time'];
    final List<dynamic> maxTemps = dailyData['temperature_2m_max'];
    final List<dynamic> minTemps = dailyData['temperature_2m_min'];
    final List<dynamic> windSpeeds = dailyData['wind_speed_10m_max'];
    final List<dynamic> wmoCodes = dailyData['weather_code'];

    return List.generate(
      times.length,
      (i) => Weather.fromJson({
        'time': times[i] as String,
        'windSpeed': windSpeeds[i] as double,
        'maxTemperature': maxTemps[i] as double,
        'minTemperature': minTemps[i] as double,
        'wmoCode': wmoCodes[i] as int,
      }),
    );
  }

  static Future<Report> fetchReport(Location location) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=${location.latitude}&longitude=${location.longitude}&daily=weather_code,temperature_2m_max,temperature_2m_min,wind_speed_10m_max&hourly=temperature_2m,weather_code,wind_speed_10m&current=temperature_2m,weather_code,wind_speed_10m',
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonResponse['current'] != null &&
            jsonResponse['hourly'] != null &&
            jsonResponse['daily'] != null) {
          return Report._fromJson(location, jsonResponse);
        } else {
          throw SearchException();
        }
      } else {
        throw APIConnectionException();
      }
    } on SocketException {
      throw APIConnectionException();
    }
  }
}
