// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therhappy/model/notes.dart';
import 'package:therhappy/provider/notes_provider.dart';
import 'package:uuid/uuid.dart';

class NewPage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const NewPage({super.key, required this.isUpdate, this.note});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  FocusNode noteFocus = FocusNode();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void addNewNote() {
    Note newNote = Note(
        id: Uuid().v1(),
        userid: firebaseAuth.currentUser!.uid,
        title: titleController.text,
        content: contentController.text,
        dateadded: DateTime.now());
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.dateadded = DateTime.now();
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
          TextField(
            controller: titleController,
            autofocus: (widget.isUpdate == true) ? false : true,
            onSubmitted: (val) {
              if (val != "") {
                noteFocus.requestFocus();
              }
            },
            style: const TextStyle(color: Colors.white, fontSize: 30),
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),
          ),
          Expanded(
            child: TextField(
              controller: contentController,
              focusNode: noteFocus,
              style: const TextStyle(
                color: Colors.white,
              ),
              maxLines: null,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type something here',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  )),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.isUpdate) {
            //Update
            updateNote();
          } else {
            addNewNote();
          }
        },
        elevation: 10,
        backgroundColor: Colors.white,
        child: const Icon(Icons.save),
      ),
    );
  }
}
