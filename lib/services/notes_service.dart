import 'dart:convert';

import 'package:rest_api_notes_project/models/api_response.dart';
import 'package:rest_api_notes_project/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': '81857097-dd3a-4bfa-b63b-7ba13b2853bf'};

  Future<APIResponse<List<NoteForListing>>> getNotesList() async {
    return http.get(Uri.parse(API + '/notes'), headers: headers).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          final note = NoteForListing(
            noteID: item['noteID'],
            noteTitle: item['noteTitle'],
            createDateTime: DateTime.parse(item['createDateTime']),
            latestEditDateTime: item['latestEditDateTime'] != null ? DateTime.parse(
              item['latestEditDateTime'] ) : DateTime.parse(item['createDateTime'],
            ),
          );
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(error: true,errorMessage: 'Error occurred');
    }).catchError((_) => APIResponse<List<NoteForListing>>(error: true,errorMessage: 'Error occurred'));
  }
}
