import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/data/note_model/note_model.dart';
import 'package:flutter_note_app/data/note_response_model/note_response_model.dart';
import 'package:flutter_note_app/data/url.dart';

abstract class ApiCalls {
  // get all notes method
  Future<List<NoteModel>> getAllNotes();

  // create Note method
  Future<NoteModel?> createNote(NoteModel note);

  // Update Note
  Future<NoteModel?> updateNote(NoteModel updatedNote);

  // Delete Note
  Future<void> deleteNote(String id);
}

class NoteAppServer implements ApiCalls {
  // Objects
  final dio = Dio();
  final url = Url();

  // Singleton instance
  static final NoteAppServer instance = NoteAppServer._internal();

  factory NoteAppServer() {
    return instance;
  }

  NoteAppServer._internal() {
    dio.options = BaseOptions(
      baseUrl: url.baseurl,
      responseType: ResponseType.plain,
    );
  }
  // NoteModel List
  ValueNotifier<List<NoteModel>> noteListNiotifier = ValueNotifier([]);

  @override
  Future<NoteModel?> createNote(NoteModel note) async {
    try {
      final response = await dio.post(url.createNote, data: note.toJson());

      return NoteModel.fromJson(jsonDecode(response.data));
    } on DioException {
      return null;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    final response=await dio.delete(Url().deleteNote.replaceFirst('{id}', id));

    if(response.data==null){
      return ;
    }else{
      final index=noteListNiotifier.value.indexWhere((note) => note.id==id);
      noteListNiotifier.value.removeAt(index);
      noteListNiotifier.notifyListeners();
    }
  }

  @override
  Future<NoteModel?> updateNote(NoteModel updatedNote) async {
    final response =
        await dio.put(Url().updateNote, data: updatedNote.toJson());
    if (response.data == null) {
      return null;
    }

    final updatedNewNote = NoteModel.fromJson(jsonDecode(response.data));

    int index =
        noteListNiotifier.value.indexWhere((note) => note.id == updatedNote.id);
    if (index == -1) {
      return null;
    } else {
      NoteAppServer.instance.noteListNiotifier.value.removeAt(index);
      NoteAppServer.instance.noteListNiotifier.value.insert(index, updatedNote);
      noteListNiotifier.notifyListeners();
    }

    return updatedNewNote;
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final response = await dio.get(url.getNote);
    if (response.data != null) {
      final noteResponse =
          NoteResponseModel.fromJson(jsonDecode(response.data));
      noteListNiotifier.value.clear();

      noteListNiotifier.value.addAll(noteResponse.data!.reversed ?? []);
      noteListNiotifier.notifyListeners();
      return noteResponse.data ?? [];
    } else {
      noteListNiotifier.value.clear();
      return [];
    }
  }
}
