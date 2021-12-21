import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_notes_project/models/api_response.dart';
import 'package:rest_api_notes_project/models/note_for_listing.dart';
import 'package:rest_api_notes_project/services/notes_service.dart';
import 'package:rest_api_notes_project/views/note_delete.dart';
import 'package:rest_api_notes_project/views/note_modify.dart';

class NoteList extends StatefulWidget {
  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.instance<NotesService>();

  late APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;

  String _formatDateTime(DateTime? dateTime) {
    return '${dateTime!.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getNotesList();
    setState(() {
      _isLoading = false;
    });
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
                .push(MaterialPageRoute(builder: (_) => NoteModify()))
                .then((_) {
              _fetchNotes();
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return CircularProgressIndicator();
            }
            if (_apiResponse.error) {
              return Center(
                child: Text(_apiResponse.errorMessage ?? 'default value'),
              );
            }
            return ListView.separated(
                separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      color: Colors.green,
                    ),
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: ValueKey(_apiResponse.data![index].noteID),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {},
                    confirmDismiss: (direction) async {
                      final result = await showDialog(
                          context: context, builder: (_) => NoteDelete());
                      if (result) {
                        final deleteResult = await service
                            .deleteNote(_apiResponse.data![index].noteID);
                        late var message;
                        if (deleteResult.data == true) {
                          message = "Note was successfully created";
                        } else {
                          message =
                              deleteResult.errorMessage ?? 'An error occurred';
                        }
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Done'),
                            content: Text(message ?? 'An error occurred'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Ok"))
                            ],
                          ),
                        );
                        return deleteResult.data;
                      }
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
                        _apiResponse.data![index].noteTitle,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text(
                          'Last edited on ${_formatDateTime(_apiResponse.data![index].latestEditDateTime)}'),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) => NoteModify(
                                      noteId: _apiResponse.data![index].noteID,
                                    )))
                            .then((data) {
                          _fetchNotes();
                        });
                      },
                    ),
                  );
                },
                itemCount: _apiResponse.data!.length);
          },
        ));
  }
}
