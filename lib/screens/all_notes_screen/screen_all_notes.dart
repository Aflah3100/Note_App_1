import 'package:flutter/material.dart';
import 'package:flutter_note_app/data/data.dart';
import 'package:flutter_note_app/data/note_model/note_model.dart';
import 'package:flutter_note_app/screens/all_notes_screen/widgets/note.dart';
import 'package:flutter_note_app/screens/update_or_delete_screen/add_or_update_screen.dart';

class ScreenDisplayNotes extends StatelessWidget {
  const ScreenDisplayNotes({super.key});

  @override
  Widget build(BuildContext context) {
    //Api Call
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await NoteAppServer.instance.getAllNotes();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: NoteAppServer.instance.noteListNiotifier,
              builder:
                  (BuildContext context, List<NoteModel> noteLists, Widget? _) {
                if (NoteAppServer.instance.noteListNiotifier.value.isEmpty) {
                  return const Center(
                      child: Text(
                    'Hey Notes!',
                    style: TextStyle(fontSize: 20),
                  ));
                }
                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  padding: const EdgeInsets.all(20.0),
                  children: List.generate(noteLists.length, (index) {
                    NoteModel currentNote = noteLists[index];
                    if (currentNote.id == null) {
                      return const SizedBox();
                    }
                    return Note(
                        id: currentNote.id!,
                        title: currentNote.title!,
                        content: currentNote.content!);
                  }),
                );
              })),
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
