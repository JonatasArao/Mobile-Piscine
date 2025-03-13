import 'package:flutter/material.dart';
import '../models/location.dart';

class WeeklyView extends StatelessWidget {
  const WeeklyView({super.key, required this.location});
  final Location location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Weekly',
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
