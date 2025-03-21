import 'package:diary_app/widgets/entry_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/note.dart';
import '../widgets/note_card.dart';

class DashView extends StatefulWidget {
  const DashView({super.key});
  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  final List<Note> notes = [
    Note(
      date: DateTime.now(),
      title: 'A Day to Remember',
      feeling: 'satisfied',
      content: 'Today was a great day!',
    ),
    Note(
      date: DateTime.now().subtract(const Duration(days: 1)),
      title: 'A Day to Not Remember',
      feeling: 'sad',
      content: 'Today was a tough day!',
    ),
    Note(
      date: DateTime.now().subtract(const Duration(days: 2)),
      title: 'An Ordinary Day',
      feeling: 'neutral',
      content: 'Nothing special happened today.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 50,
          bottom: 10,
          left: 15,
          right: 15,
        ),
        color: Colors.blueGrey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Your last diary entries',
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(
                  note: note,
                  onTap:
                      () => showDialog(
                        context: context,
                        builder:
                            (context) => EntryDialog(
                              note: note,
                              onDelete: () {
                                setState(() {
                                  notes.remove(note);
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                      ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          debugPrint('Elevated Button Pressed');
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
        child: const Text('New diary entry'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
