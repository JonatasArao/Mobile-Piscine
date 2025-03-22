import 'note.dart';

class Diary {
  final List<Note> _notes;

  Diary({List<Note>? notes}) : _notes = notes ?? [];

  List<Note> get notes => _notes;

  void addNote(Note newNote) {
    _notes.add(newNote);
  }

  bool removeNote(Note note) {
    return _notes.remove(note);
  }
}
