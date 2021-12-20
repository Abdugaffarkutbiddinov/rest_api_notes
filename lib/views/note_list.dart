import 'package:flutter/material.dart';
import 'package:rest_api_notes_project/models/note_for_listing.dart';
import 'package:rest_api_notes_project/views/note_delete.dart';
import 'package:rest_api_notes_project/views/note_modify.dart';

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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('List of notes')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NoteModify()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
          separatorBuilder: (_, __) => const Divider(
                height: 1,
                color: Colors.green,
              ),
          itemBuilder: (_, index) {
            return Dismissible(
              key: ValueKey(notes[index].noteID),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {},
              confirmDismiss: (direction) async {
                final result = await showDialog(
                    context: context, builder: (_) => NoteDelete());
                print(result);
                return result;
              },
              background: Container(
                color: Colors.redAccent,
                padding: EdgeInsets.only(left: 16.0),
                child: Align(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              child: ListTile(
                title: Text(
                  notes[index].noteTitle,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text(
                    'Last edited on ${_formatDateTime(notes[index].lastEditedDateTime)}'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => NoteModify(
                            noteId: notes[index].noteID,
                          )));
                },
              ),
            );
          },
          itemCount: notes.length),
    );
  }
}
