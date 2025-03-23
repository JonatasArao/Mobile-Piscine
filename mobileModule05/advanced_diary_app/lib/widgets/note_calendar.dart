import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/note.dart';
import '../services/diary.dart';
import '../widgets/note_card.dart';
import '../widgets/entry_dialog.dart';

class NoteCalendar extends StatefulWidget {
  const NoteCalendar({super.key});

  @override
  NoteCalendarState createState() => NoteCalendarState();
}

class NoteCalendarState extends State<NoteCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _calendarFormat = MediaQuery.of(context).orientation == Orientation.landscape
      ? CalendarFormat.week
      : CalendarFormat.month;
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<List<Note>>(
        stream: Diary.streamAllNotes(),
        initialData: const [],
        builder: (context, snapshot) {
          final notes = snapshot.data ?? [];
          final Map<DateTime, List<Note>> events = {};

          for (var note in notes) {
            final date = DateTime.utc(
              note.date.year,
              note.date.month,
              note.date.day,
            );
            events.putIfAbsent(date, () => []).add(note);
          }

          List<Note> getEventsForDay(DateTime day) =>
              events[DateTime.utc(day.year, day.month, day.day)] ?? [];

          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
                lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                eventLoader: (day) =>
                    events[DateTime.utc(day.year, day.month, day.day)] ?? [],
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: MediaQuery.of(context).orientation == Orientation.landscape
                  ? null
                  : (format) {
                    setState(() {
                    _calendarFormat = format;
                    });
                  },
                calendarStyle: CalendarStyle(
                  defaultTextStyle: const TextStyle(color: Colors.white),
                  weekendTextStyle: const TextStyle(color: Colors.grey),
                  selectedDecoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),
                  markersMaxCount: 1,
                  markerDecoration: BoxDecoration(
                    color: Colors.tealAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: getEventsForDay(_selectedDay).length,
                  itemBuilder: (context, index) {
                    final note = getEventsForDay(_selectedDay)[index];
                    return NoteCard(
                      note: note,
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => EntryDialog(
                          note: note,
                          onDelete: () async {
                            try {
                              Navigator.of(context).pop(note);
                              await Diary.deleteNote(note);
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to delete note: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
