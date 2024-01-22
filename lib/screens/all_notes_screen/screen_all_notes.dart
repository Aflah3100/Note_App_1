import 'package:flutter/material.dart';
import 'package:flutter_note_app/screens/all_notes_screen/widgets/note.dart';
import 'package:flutter_note_app/screens/update_or_delete_screen/add_or_update_screen.dart';

class ScreenDisplayNotes extends StatelessWidget {
  const ScreenDisplayNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          padding: const EdgeInsets.all(20.0),
          children: List.generate(
            10,
            (index) => Note(
              id: index.toString(),
              title: 'Lorem Ipsum',
              content:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(ScreenNoteEdit.addRouteName);
        },
        label: const Text('Add Note'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
