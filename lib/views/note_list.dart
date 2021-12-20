import 'package:flutter/material.dart';
import 'package:rest_api_notes_project/models/note_for_listing.dart';

class NoteList extends StatelessWidget {
  NoteList({Key? key}) : super(key: key);
  final notes = [
    NoteForListing(
        noteID: "1",
        noteTitle: "Note 1",
        createDateTime: DateTime.now(),
        lastEditedDateTime: DateTime.now()),
    NoteForListing(
        noteID: "2",
        noteTitle: "Note 2",
        createDateTime: DateTime.now(),
        lastEditedDateTime: DateTime.now()),
    NoteForListing(
        noteID: "3",
        noteTitle: "Note 3",
        createDateTime: DateTime.now(),
        lastEditedDateTime: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('List of notes')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
          separatorBuilder: (_, __) => const Divider(
                height: 1,
                color: Colors.green,
              ),
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(
                notes[index].noteTitle,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text('Last edited on ${notes[index].lastEditedDateTime}'),
            );
          },
          itemCount: notes.length),
    );
  }
}
