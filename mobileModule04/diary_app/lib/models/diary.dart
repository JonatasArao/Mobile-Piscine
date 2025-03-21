import 'package:diary_app/models/note.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Diary {
  final User _user;
  List<Note> notes;

  Diary(this._user, {this.notes = const []});
}
