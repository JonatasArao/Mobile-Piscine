import 'package:advanced_diary_app/services/auth.dart';
import 'package:advanced_diary_app/widgets/last_entrys.dart';
import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/diary.dart';
import '../widgets/entry_form_dialog.dart';

class DashView extends StatefulWidget {
  const DashView({super.key});
  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await Auth.sigOut();
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
            LastEntries(),
          ],
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
                await Diary.addNote(newNote);
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
