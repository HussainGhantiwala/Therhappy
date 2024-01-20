// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therhappy/colors/journal_color.dart';
import 'package:therhappy/model/notes.dart';
import 'package:therhappy/pages/new_page.dart';
import 'package:therhappy/provider/notes_provider.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  String searchQuery = "";
  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Journal",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(6.4, 6.4),
                                blurRadius: 0)
                          ],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Image(
                        image: AssetImage('assets/images/arrow-up-z-a.png'),
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(6, 7.4),
                        blurRadius: 0)
                  ],
                  borderRadius: BorderRadius.circular(30.0)),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    searchQuery = val;
                  });
                },
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    hintText: 'Search notes...',
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Colors.grey,
                    ),
                    fillColor: Colors.grey.shade800,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Expanded(
                child: (notesProvider.notes.isNotEmpty)
                    ? (notesProvider.getFilteredNotes(searchQuery).isNotEmpty)
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: notesProvider
                                .getFilteredNotes(searchQuery)
                                .length,
                            itemBuilder: (context, index) {
                              Note currentNote = notesProvider
                                  .getFilteredNotes(searchQuery)[index];
                              return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(6, 7.4),
                                            blurRadius: 0)
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => NewPage(
                                                  isUpdate: true,
                                                  note: currentNote)));
                                    },
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: getRandomColor(),
                                      child: ListTile(
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: '${currentNote.title}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      height: 1.5,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              RichText(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  text: TextSpan(
                                                    text:
                                                        '${currentNote.content}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14,
                                                        height: 1.5),
                                                  )),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Text(
                                                  'Edited:${currentNote.dateadded}',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              )

                                              // Text(
                                              //   currentNote.title!,
                                              //   style: TextStyle(
                                              //       fontWeight: FontWeight.bold,
                                              //       fontSize: 20,
                                              //       color: Colors.black),
                                              //   maxLines: 1,
                                              //   overflow: TextOverflow.ellipsis,
                                              // )
                                            ],
                                          ),
                                          // subtitle: Padding(
                                          //   padding: const EdgeInsets.only(top: 8.0),
                                          //   child: Text(
                                          //     '${currentNote.dateadded}',
                                          //     style: TextStyle(
                                          //         fontSize: 10,
                                          //         color: Colors.grey.shade800,
                                          //         fontStyle: FontStyle.italic),
                                          //   ),
                                          // ),
                                          trailing: IconButton(
                                              onPressed: () async {
                                                final result =
                                                    await confirmDialog(
                                                        context);
                                                if (result != null && result) {
                                                  notesProvider
                                                      .deleteNote(currentNote);
                                                }
                                              },
                                              icon: Image(
                                                image: AssetImage(
                                                    'assets/images/trash-2.png'),
                                                color: Colors.black,
                                              ))),
                                    ),
                                  ));
                            },
                          )
                        : (notesProvider.isloading == false)
                            ? Center(
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/entries.png')))
                            : Center(
                                child: CircularProgressIndicator(),
                              )
                    : (notesProvider.isloading == false)
                        ? Center(
                            child: Image(
                                image: AssetImage('assets/images/entries.png')))
                        : Center(
                            child: CircularProgressIndicator(),
                          ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const NewPage(
                        isUpdate: false,
                      )));
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 38,
        ),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: const Text(
              'Are you sure you want to delete?',
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ]),
          );
        });
  }
}
