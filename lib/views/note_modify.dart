import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  final String? noteId;

  bool get isEditing => noteId != null;

  NoteModify({this.noteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(isEditing ? 'Edit note' : 'Create note')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Note title'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Note content'),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
