import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_note_app/data/note_model/note_model.dart';
import 'package:flutter_note_app/data/note_response_model/note_response_model.dart';
import 'package:flutter_note_app/data/url.dart';

abstract class ApiCalls {
  //get all notes method
  Future<List<NoteModel>> getAllNotes();
  //create Note method
  Future<NoteModel?> createNote(NoteModel note);
  //Update Note
  Future<NoteModel?> updateNote(NoteModel note);
  //Delete Note
  Future<void> deleteNote(String id);
}

class NoteAppServer implements ApiCalls {
  final dio = Dio();
  final url = Url();

  NoteAppServer() {
    dio.options = BaseOptions(
      baseUrl: url.baseurl,
      responseType: ResponseType.json,
    );
  }
  @override
  Future<NoteModel?> createNote(NoteModel note) async {
    final response = await dio.post(url.createNote, data: note.toJson());

    return NoteModel.fromJson(response.data);
  }

  @override
  Future<void> deleteNote(String id) async {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<NoteModel?> updateNote(NoteModel note) async {
    // TODO: implement updateNote
    throw UnimplementedError();
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final response =
        await dio.get<NoteResponseModel>(url.getNote);
    if (response.data == null) {
      // If response.data is null, return an empty list
      return [];
    }

    return response.data!.data ?? [];
  }
}
