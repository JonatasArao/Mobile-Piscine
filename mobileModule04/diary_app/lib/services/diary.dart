import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note.dart';
import 'auth.dart';

class Diary {
  final CollectionReference _notesCollection = FirebaseFirestore.instance
      .collection('notes');
  final User? currentUser = Auth().currentUser;

  Stream<List<Note>> streamNotes() {
    try {
      String email;

      if (currentUser == null) {
        throw Exception('User is not authenticated.');
      }
      email = currentUser?.email ?? '';
      if (email.isEmpty) {
        throw Exception('User email is not available.');
      }
      return _notesCollection
          .where('usermail', isEqualTo: email)
          .orderBy('date', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return Note.fromJson(doc.data() as Map<String, dynamic>, doc.id);
            }).toList();
          });
    } catch (e) {
      throw Exception('Failed to stream notes: $e');
    }
  }

  Future<void> addNote(Note newNote) async {
    try {
      if (currentUser == null) {
        throw Exception('User is not authenticated.');
      }
      final email = currentUser?.email ?? '';
      if (email.isEmpty) {
        throw Exception('User email is not available.');
      }
      final noteData = newNote.toJson();
      noteData['usermail'] = email;
      await _notesCollection.add(noteData);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteNote(Note note) async {
    try {
      await _notesCollection.doc(note.id).delete();
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
