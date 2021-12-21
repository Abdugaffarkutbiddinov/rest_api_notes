import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_notes_project/models/note.dart';
import 'package:rest_api_notes_project/services/notes_service.dart';

class NoteModify extends StatefulWidget {
  final String? noteId;

  NoteModify({this.noteId});

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteId != null;

  NotesService get noteService => GetIt.instance<NotesService>();
  String? errorMessage;
  late Note note;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    noteService.getNote(widget.noteId).then((response) {
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      note = response.data!;
      _titleController.text = note.noteTitle;
      _contentController.text = note.noteContent;
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(isEditing ? 'Edit note' : 'Create note')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Note title'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _contentController,
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
