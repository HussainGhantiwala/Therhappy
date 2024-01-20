import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:therhappy/model/notes.dart';
import 'package:therhappy/services/api_service.dart';

class NotesProvider with ChangeNotifier {
  bool isloading = true;
  List<Note> notes = [];
  NotesProvider() {
    fetchNotes();
  }

  List<Note> getFilteredNotes(String searchQuery) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.content!.toLowerCase().contains(searchQuery))
        .toList();
  }

  void sortNotes() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
    sortNotes();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    notes = await ApiService.fetchNotes(firebaseAuth.currentUser!.uid);
    sortNotes();
    isloading = false;
    notifyListeners();
  }
}
