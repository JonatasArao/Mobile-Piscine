class Weather {
  DateTime time;
  double windSpeed;
  double maxTemperature;
  double minTemperature;
  int wmoCode;

  Weather._({
    required this.time,
    required this.windSpeed,
    required this.maxTemperature,
    required this.minTemperature,
    required this.wmoCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    try {
      return Weather._(
        time: DateTime.parse(json['time'] as String),
        windSpeed: json['windSpeed'] as double,
        maxTemperature: json['maxTemperature'] as double,
        minTemperature: json['minTemperature'] as double,
        wmoCode: json['wmoCode'] as int,
      );
    } catch (e) {
      throw FormatException('Failed to load weather: $json');
    }
  }
}
