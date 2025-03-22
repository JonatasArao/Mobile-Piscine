import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Note {
  final DateTime _date;
  final String _title;
  final String _feeling;
  final String _content;

  Note({
    required DateTime date,
    required String title,
    required String feeling,
    required String content,
  }) : _date = date,
       _title = title,
       _feeling = feeling,
       _content = content;

  static const Map<String, IconData> feelings = {
    "satisfied": FontAwesomeIcons.faceLaugh,
    "happy": FontAwesomeIcons.faceSmile,
    "sad": FontAwesomeIcons.faceFrown,
    "angry": FontAwesomeIcons.faceAngry,
    "surprised": FontAwesomeIcons.faceSurprise,
    "neutral": FontAwesomeIcons.faceMeh,
    "excited": FontAwesomeIcons.faceGrinStars,
    "tired": FontAwesomeIcons.faceTired,
    "confused": FontAwesomeIcons.faceFlushed,
    "love": FontAwesomeIcons.faceGrinHearts,
    "sick": FontAwesomeIcons.faceDizzy,
  };

  static const Map<int, String> monthNames = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };
  static const Map<int, String> dayNames = {
    1: "Sunday",
    2: "Monday",
    3: "Tuesday",
    4: "Wednesday",
    5: "Thursday",
    6: "Friday",
    7: "Saturday",
  };

  int get day => _date.day;
  String get dayName => dayNames[_date.weekday] ?? 'Unknown';
  int get month => _date.month;
  String get monthName => monthNames[_date.month] ?? 'Unknown';
  int get year => _date.year;
  String get formattedDate => '$dayName, $monthName $day, $year';
  String get title => _title;
  String get feeling => _feeling;
  String get content => _content;
  IconData get feelingIcon =>
      feelings[_feeling] ?? FontAwesomeIcons.faceMehBlank;
}
