import 'package:flutter/material.dart';
import 'package:flutter_note_app/data/data.dart';
import 'package:flutter_note_app/data/note_model/note_model.dart';
import 'package:flutter_note_app/screens/all_notes_screen/widgets/note.dart';

// Action type
enum ActionType { addNote, editNote }

// Screen to add and update note
class ScreenNoteEdit extends StatelessWidget {
  // Route Name
  static String editRouteName = 'Note Edit Page';
  static String addRouteName = 'Note Add Page';

  // Action
  final ActionType screenMode;
  String? id;

  //Edit Note Details
  String? presentTitle;
  String? presentContent;

  //controller
  final _titleController = TextEditingController();
  final _noteContentController = TextEditingController();

  ScreenNoteEdit(
      {super.key,
      required this.screenMode,
      this.id,
      this.presentTitle,
      this.presentContent});

  //keys
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    //Collect note data
    if (screenMode == ActionType.editNote) {
      _titleController.text = presentTitle!;
      _noteContentController.text = presentContent!;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: (screenMode == ActionType.addNote)
            ? const Text('Add Note')
            : const Text('Edit Note'),
        centerTitle: true,
        actions: [
          TextButton.icon(
              onPressed: () {
                switch (screenMode) {
                  case ActionType.addNote:
                    saveData();

                    break;

                  case ActionType.editNote:
                    editAndSaveData(context);
                    break;
                }
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Title text field
              Form(
                key: formKey1,
                child: TextFormField(
                  validator: (title) => (title == null || title.isEmpty)
                      ? 'Title is Emplty'
                      : null,
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              // Flexible widget with flex factor 1 to make the Note field take all remaining space
              Form(
                key: formKey2,
                child: Flexible(
                  child: TextFormField(
                    validator: (content) => (content == null || content.isEmpty)
                        ? 'Note is Empty'
                        : null,
                    controller: _noteContentController,
                    maxLines: 200,
                    decoration: InputDecoration(
                      hintText: 'Note',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //Save button Function

  Future<void> saveData() async {
    if ((formKey1.currentState!.validate()) &&
        (formKey2.currentState!.validate())) {
      final NoteModel note = NoteModel.create(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleController.text,
          content: _noteContentController.text);

      final returnNote = await NoteAppServer().createNote(note);
      if (returnNote != null) {
        //Success
        Navigator.of(scaffoldKey.currentContext!).pop();
        NoteAppServer.instance.getAllNotes();
      } else {
        //Fail
      }
    }
  }

  //edit function
  Future<void> editAndSaveData(BuildContext context) async {
    if (_titleController.text.isEmpty && _noteContentController.text.isEmpty) {
      await Note.deleteNote(id!);
      Navigator.of(scaffoldKey.currentContext!).pop();
    } else if (formKey2.currentState!.validate() && formKey1.currentState!.validate()) {
      final updatedTitle = _titleController.text;
      final updatedContent = _noteContentController.text;
      final newNote = NoteModel.create(
          id: id, title: updatedTitle, content: updatedContent);
      final updatedNote = await NoteAppServer.instance.updateNote(newNote);
      if (updatedNote == null) {
        //failed to update
        Navigator.of(scaffoldKey.currentContext!).pop();
      } else {
        Navigator.of(scaffoldKey.currentContext!).pop();
      }
    }
  }
}
