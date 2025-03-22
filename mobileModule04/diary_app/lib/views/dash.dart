import 'package:flutter/material.dart';
import '../models/note.dart';
import '../models/diary.dart';
import '../widgets/entry_dialog.dart';
import '../widgets/entry_form_dialog.dart';
import '../widgets/note_card.dart';

class DashView extends StatefulWidget {
  const DashView({super.key});
  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  final Diary diary = Diary();
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
  void initState() {
    super.initState();
    notes.forEach(diary.addNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          color: Colors.blueGrey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Your last diary entries',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: diary.notes.length,
                  itemBuilder: (context, index) {
                    final note = diary.notes[index];
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
                                      diary.removeNote(note);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                          ),
                    );
                  },
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 10),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const EntryFormDialog(),
          ).then((newNote) {
            if (newNote != null && newNote is Note) {
              setState(() {
                diary.addNote(newNote);
              });
            }
          });
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[900]),
        child: const Text('New diary entry'),
      ),
      floatingActionButtonLocation:
          MediaQuery.of(context).orientation == Orientation.landscape
              ? FloatingActionButtonLocation.endFloat
              : FloatingActionButtonLocation.centerFloat,
    );
  }
}
