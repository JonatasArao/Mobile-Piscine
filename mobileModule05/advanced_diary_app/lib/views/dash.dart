import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/diary.dart';
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
              StreamBuilder<List<Note>>(
                stream: diary.streamNotes(),
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '${snapshot.error}',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }  else if (snapshot.hasData) {
                    final notes = snapshot.data!;
                    if (notes.isEmpty)
                    {
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
                                            await diary.deleteNote(note);
                                          } catch (e) {
                                            if (mounted) {
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
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      heightFactor: 2,
                      child: CircularProgressIndicator(
                        color: Colors.tealAccent,
                      ),
                    );
                  } else {
                    return Center(child: Text('Unknown error occurred'));
                  }
                },
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
          ).then((newNote) async {
            if (newNote != null && newNote is Note) {
              try {
                await diary.addNote(newNote);
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to add note: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
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
