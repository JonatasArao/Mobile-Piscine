import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'exceptions.dart';
import 'dart:io';

class Location {
  final double _latitude;
  final double _longitude;
  final String _name;
  final String _region;
  final String _country;
  final String _countryCode;

  const Location._({
    required double latitude,
    required double longitude,
    required String name,
    required String region,
    required String country,
    required String countryCode,
  }) : _latitude = latitude,
       _longitude = longitude,
       _name = name,
       _region = region,
       _country = country,
       _countryCode = countryCode;

  factory Location._fromGeolocation(Position position, Placemark placemark) {
    return Location._(
      latitude: position.latitude,
      longitude: position.longitude,
      name: placemark.subAdministrativeArea ?? 'Unknown',
      region: placemark.administrativeArea ?? 'Unknown',
      country: placemark.country ?? 'Unknown',
      countryCode: placemark.isoCountryCode ?? 'Unknown',
    );
  }

  factory Location._fromJson(Map<String, dynamic> json) {
    try {
      return Location._(
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        name: json['name'] as String,
        region: json['admin1'] ?? '',
        country: json['country'] as String,
        countryCode: json['country_code'] as String,
      );
    } catch (e) {
      throw APIConnectionException();
    }
  }

  double get latitude => _latitude;
  double get longitude => _longitude;
  String get name => _name;
  String get region => _region;
  String get country => _country;
  String get flag {
    return _countryCode
        .toUpperCase()
        .codeUnits
        .map((codeUnit) => String.fromCharCode(codeUnit + 127397))
        .join();
  }

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
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      location = Location._fromGeolocation(position, placemarks.first);
      return (location);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<Location>> fetchLocations(String name, int count) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=$name&count=$count',
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonResponse['results'] != null) {
          List<dynamic> jsonList = jsonResponse['results'] as List<dynamic>;
          return jsonList
              .map((json) => Location._fromJson(json as Map<String, dynamic>))
              .toList();
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
