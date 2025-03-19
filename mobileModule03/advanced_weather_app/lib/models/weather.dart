import 'package:flutter/material.dart';

class Weather {
  final DateTime _time;
  final double _windSpeed;
  final double _maxTemperature;
  final double _minTemperature;
  final int _weatherCode;
  final String _maxTemperatureUnit;
  final String _minTemperatureUnit;
  final String _windSpeedUnit;

  Weather._({
    required DateTime time,
    required double windSpeed,
    required double maxTemperature,
    required double minTemperature,
    required int weatherCode,
    required String maxTemperatureUnit,
    required String minTemperatureUnit,
    required String windSpeedUnit,
  }) : _time = time,
       _windSpeed = windSpeed,
       _maxTemperature = maxTemperature,
       _minTemperature = minTemperature,
       _weatherCode = weatherCode,
       _maxTemperatureUnit = maxTemperatureUnit,
       _minTemperatureUnit = minTemperatureUnit,
       _windSpeedUnit = windSpeedUnit;

  static const Map<int, String> _weatherDescriptions = {
    0: "Clear sky",
    1: "Mainly clear",
    2: "Partly cloudy",
    3: "Overcast",
    45: "Fog",
    48: "Depositing rime fog",
    51: "Light drizzle",
    53: "Moderate drizzle",
    55: "Dense drizzle",
    56: "Light freezing drizzle",
    57: "Dense freezing drizzle",
    61: "Slight rain",
    63: "Moderate rain",
    65: "Heavy rain",
    66: "Light freezing rain",
    67: "Heavy freezing rain",
    71: "Slight snow fall",
    73: "Moderate snow fall",
    75: "Heavy snow fall",
    77: "Snow grains",
    80: "Slight rain showers",
    81: "Moderate rain showers",
    82: "Violent rain showers",
    85: "Slight snow showers",
    86: "Heavy snow showers",
    95: "Thunderstorm",
    96: "Thunderstorm with slight hail",
    99: "Thunderstorm with heavy hail",
  };

  static const Map<int, IconData> _weatherIcons = {
    0: Icons.wb_sunny, // Clear sky
    1: Icons.wb_sunny, // Mainly clear
    2: Icons.cloud, // Partly cloudy
    3: Icons.cloud, // Overcast
    45: Icons.foggy, // Fog
    48: Icons.foggy, // Depositing rime fog
    51: Icons.grain, // Light drizzle
    53: Icons.grain, // Moderate drizzle
    55: Icons.grain, // Dense drizzle
    56: Icons.ac_unit, // Light freezing drizzle
    57: Icons.ac_unit, // Dense freezing drizzle
    61: Icons.umbrella, // Slight rain
    63: Icons.umbrella, // Moderate rain
    65: Icons.umbrella, // Heavy rain
    66: Icons.ac_unit, // Light freezing rain
    67: Icons.ac_unit, // Heavy freezing rain
    71: Icons.ac_unit, // Slight snow fall
    73: Icons.ac_unit, // Moderate snow fall
    75: Icons.ac_unit, // Heavy snow fall
    77: Icons.ac_unit, // Snow grains
    80: Icons.shower, // Slight rain showers
    81: Icons.shower, // Moderate rain showers
    82: Icons.shower, // Violent rain showers
    85: Icons.ac_unit, // Slight snow showers
    86: Icons.ac_unit, // Heavy snow showers
    95: Icons.flash_on, // Thunderstorm
    96: Icons.flash_on, // Thunderstorm with slight hail
    99: Icons.flash_on, // Thunderstorm with heavy hail
  };

  String get time =>
      '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';
  String get date =>
      '${_time.day.toString().padLeft(2, '0')}/${_time.month.toString().padLeft(2, '0')}';
  String get windSpeed => '$_windSpeed $_windSpeedUnit';
  String get maxTemperature => '$_maxTemperature$_maxTemperatureUnit';
  String get minTemperature => '$_minTemperature$_minTemperatureUnit';
  String get maxTemperatureUnit => _maxTemperatureUnit;
  String get minTemperatureUnit => _minTemperatureUnit;
  double get maxTemperatureValue => _maxTemperature;
  double get minTemperatureValue => _minTemperature;
  String get description => _weatherDescriptions[_weatherCode] ?? "Unknown";
  IconData get icon => _weatherIcons[_weatherCode] ?? Icons.help_outline;

  factory Weather.fromJson(Map<String, dynamic> json) {
    try {
      return Weather._(
        time: DateTime.parse(json['time'] as String),
        windSpeed: json['windSpeed'] as double,
        maxTemperature: json['maxTemperature'] as double,
        minTemperature: json['minTemperature'] as double,
        weatherCode: json['weatherCode'] as int,
        maxTemperatureUnit: json['maxTemperatureUnit'] as String,
        minTemperatureUnit: json['minTemperatureUnit'] as String,
        windSpeedUnit: json['windSpeedUnit'] as String,
      );
    } catch (e) {
      throw FormatException('Failed to load weather: $json');
    }
  }
  static double getMaxTemperatureFromList(List<Weather> weatherList) {
    if (weatherList.isEmpty) {
      throw ArgumentError('The weather list cannot be empty.');
    }
    return weatherList.map((weather) => weather.maxTemperatureValue).reduce((a, b) {
      if (a > b) {
        return a;
      } else {
        return b;
      }
    });
  }

  static double getMinTemperatureFromList(List<Weather> weatherList) {
    if (weatherList.isEmpty) {
      throw ArgumentError('The weather list cannot be empty.');
    }
    return weatherList.map((weather) => weather.minTemperatureValue).reduce((a, b) {
      if (a < b) {
        return a;
      } else {
        return b;
      }
    });
  }
}
