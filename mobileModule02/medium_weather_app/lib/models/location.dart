import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Location {
  final double _latitude;
  final double _longitude;
  final String? _name;
  final String? _region;
  final String? _country;

  const Location._({
    required double latitude,
    required double longitude,
    String? name,
    String? region,
    String? country,
  }) : _latitude = latitude,
       _longitude = longitude,
       _name = name,
       _region = region,
       _country = country;

  factory Location._fromGeolocation(Position position) {
    return Location._(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  factory Location._fromJson(Map<String, dynamic> json) {
    try {
    return Location._(
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        name: json['name'] as String?,
        region: json['admin1'] as String?,
        country: json['country'] as String?,
      );
    } catch (e) {
      throw FormatException('Failed to load location: $json');
    }
  }

  double get latitude => _latitude;
  double get longitude => _longitude;
  String? get name => _name;
  String? get region => _region;
  String? get country => _country;

  static Future<Location> fetchGeolocation() async {
    Location location;
    Position position;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Geolocation is not available, please enable it.';
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          throw 'Geolocation is not available, location permissions are denied';
        }
      }
      position = await Geolocator.getCurrentPosition().timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw 'Geolocation request timed out. Please try again.';
        },
      );
      location = Location._fromGeolocation(position);
      return (location);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<Location>> fetchLocations(String name) async {
    final response = await http.get(
      Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$name'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      List<dynamic> jsonList = jsonResponse['results'] as List<dynamic>;
      return jsonList.map((json) => Location._fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }
}
