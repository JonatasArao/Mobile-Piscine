import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/note.dart';
import '../services/diary.dart';
import '../widgets/top_bar.dart';
import '../widgets/last_entrys.dart';
import '../widgets/feeling_report.dart';
import '../widgets/entry_form_dialog.dart';

class DashView extends StatefulWidget {
  const DashView({super.key});
  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    TopBar(),
                    LastEntries(),
                    FeelingReport(),
                  ],
                ),
              ),
              Center(
                child: Text('Another Tab Content'),
              ),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.zero,
          color: Colors.grey[900],
          child: TabBar(
            indicator: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.cyan, width: 2.0),
              ),
            ),
            labelColor: Colors.cyan,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(icon: FaIcon(FontAwesomeIcons.user, size: 25)),
              Tab(icon: FaIcon(FontAwesomeIcons.calendarDay, size: 25)),
            ],
          ),
        ),
      ),
    );
  }
}
