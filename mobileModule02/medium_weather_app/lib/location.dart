import 'package:geolocator/geolocator.dart';

class Location {
  final double _latitude;
  final double _longitude;

  const Location._({required double latitude, required double longitude})
    : _latitude = latitude,
      _longitude = longitude;

  factory Location._fromGeolocation(Position position) {
    return Location._(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  double get latitude => _latitude;
  double get longitude => _longitude;

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
}
