import 'package:flutter/material.dart';
import '../models/location.dart';

class CurrentlyView extends StatelessWidget {
  const CurrentlyView({super.key, required this.location});
  final Location location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Currently',
            style: TextStyle(
              fontSize: 30,
              height: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
            Text(
              '${location.latitude} ${location.longitude}',
              style: TextStyle(fontSize: 30, height: 1),
            ),
        ],
      ),
    );
  }
}
