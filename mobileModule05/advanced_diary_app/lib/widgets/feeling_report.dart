import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/note.dart';
import '../services/diary.dart';

class FeelingReport extends StatelessWidget {
  const FeelingReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal[900],
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder<List<Note>>(
            stream: Diary.streamAllNotes(),
            initialData: const [],
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '${snapshot.error}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                final notes = snapshot.data!;
                final percentages = Note.feelingsPercentage(notes);
                if (notes.isEmpty) {
                  return const Center(
                    child: Text(
                      'No entries found',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                return Column(
                  children: [
                    Center(
                      child: Text(
                        'Your feel for your ${notes.length} entries',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: percentages.length,
                      itemBuilder: (context, index) {
                        final feeling = percentages.keys.elementAt(index);
                        final percentage = percentages[feeling]!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  FaIcon(Note.feelings[feeling]),
                                  const SizedBox(width: 10),
                                  Text(
                                    feeling,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${percentage.toStringAsFixed(2)}%',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 7),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  heightFactor: 2,
                  child: CircularProgressIndicator(
                    color: Colors.tealAccent,
                  ),
                );
              } else {
                return const Center(
                  child: Text('Unknown error occurred'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
