import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Note {
  final String _id;
  final String _title;
  final String _feeling;
  final String _content;
  final DateTime _date;

  Note({
    required String id,
    required String title,
    required String feeling,
    required String content,
    required DateTime date,
  }) : _id = id,
       _title = title,
       _feeling = feeling,
       _content = content,
       _date = date;

  factory Note.fromJson(Map<String, dynamic> json, String id) {
    return Note(
      id: id,
      title: json['title'] as String,
      feeling: json['icon'] as String,
      content: json['text'] as String,
      date: (json['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': content,
      'icon': feeling,
      'date': Timestamp.fromDate(_date),
    };
  }

  static Map<String, double> feelingsPercentage(List<Note> notes) {
    final Map<String, int> counts = {};
    for (var note in notes) {
      counts[note.feeling] = (counts[note.feeling] ?? 0) + 1;
    }
    final total = notes.length;
    final Map<String, double> percentages = {};
    feelings.keys.forEach((feeling) {
      final countValue = counts[feeling] ?? 0;
      percentages[feeling] = (countValue / total) * 100;
    });
    return percentages;
  }

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

  String get id => _id;
  String get title => _title;
  String get feeling => _feeling;
  String get content => _content;
  int get day => _date.day;
  String get dayName => dayNames[_date.weekday] ?? 'Unknown';
  int get month => _date.month;
  String get monthName => monthNames[_date.month] ?? 'Unknown';
  int get year => _date.year;
  DateTime get date => _date;
  String get formattedDate => '$dayName, $monthName $day, $year';
  IconData get feelingIcon =>
      feelings[_feeling] ?? FontAwesomeIcons.faceMehBlank;
}
