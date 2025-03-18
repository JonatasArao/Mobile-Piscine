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

  String get time =>
      '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';
  String get date =>
      '${_time.year}-${_time.month.toString().padLeft(2, '0')}-${_time.day.toString().padLeft(2, '0')}';
  String get windSpeed => '$_windSpeed $_windSpeedUnit';
  String get maxTemperature => '$_maxTemperature$_maxTemperatureUnit';
  String get minTemperature => '$_minTemperature$_minTemperatureUnit';
  String get description => _weatherDescriptions[_weatherCode] ?? "Unknown";

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
}
