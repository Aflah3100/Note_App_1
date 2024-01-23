import 'package:flutter/material.dart';
import 'package:flutter_note_app/data/data.dart';
import 'package:flutter_note_app/data/note_model/note_model.dart';

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

  //controller
  final _titleController = TextEditingController();
  final _noteContentController = TextEditingController();
  ScreenNoteEdit({super.key, required this.screenMode, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    saveData(context);

                    break;

                  case ActionType.editNote:

                    //Edit Note
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
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              // Flexible widget with flex factor 1 to make the Note field take all remaining space
              Flexible(
                child: TextFormField(
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
            ],
          ),
        ),
      ),
    );
  }
  //Save button Function

  Future<void> saveData(BuildContext context) async {
    final NoteModel note = NoteModel.create(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        content: _noteContentController.text);


    await NoteAppServer().createNote(note);
  }
}
