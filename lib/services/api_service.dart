// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:developer';
import 'package:therhappy/model/notes.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //ngrok http --domain=meet-cobra-intent.ngrok-free.app 5000 -use this to start the server
  static String _baseURL = "https://meet-cobra-intent.ngrok-free.app/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse(_baseURL + "/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse(_baseURL + "/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse(_baseURL + "/list");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decoded = jsonDecode(response.body);
    List<Note> notes = [];
    for (var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }
    return notes;
  }
}
