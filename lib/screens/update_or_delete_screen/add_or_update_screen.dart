import 'package:flutter/material.dart';

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
  ScreenNoteEdit({super.key, required this.screenMode, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (screenMode == ActionType.addNote)
            ? const Text('Add Note')
            : const Text('Edit Note'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Title text field
              TextFormField(
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
}
