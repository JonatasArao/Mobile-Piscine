import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/diary.dart';
import 'note_card.dart';
import 'entry_dialog.dart';

class LastEntries extends StatelessWidget {
  const LastEntries({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      color: Colors.blueGrey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Your last diary entries',
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          StreamBuilder<List<Note>>(
            stream: Diary.streamNotes(2),
            initialData: const [],
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '${snapshot.error}',
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                final notes = snapshot.data!;
                if (notes.isEmpty) {
                  return const Center(
                    child: Text(
                      'No entries found',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                return Flexible(
                  fit: FlexFit.loose,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                                    onDelete: () async {
                                      try {
                                        Navigator.of(context).pop(note);
                                        await Diary.deleteNote(note);
                                      } catch (e) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Failed to delete note: $e',
                                              ),
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
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 10),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  heightFactor: 2,
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                );
              } else {
                return const Center(child: Text('Unknown error occurred'));
              }
            },
          ),
        ],
      ),
    );
  }
}
