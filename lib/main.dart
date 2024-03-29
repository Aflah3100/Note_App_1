import 'package:flutter/material.dart';
import 'package:flutter_note_app/screens/all_notes_screen/Screen_All_Notes.dart';
import 'package:flutter_note_app/screens/update_or_delete_screen/add_or_update_screen.dart';
import 'package:flutter_note_app/utils/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note-App',
      themeMode: ThemeMode.system,
      theme: ThemeManager().lightTheme,
      darkTheme: ThemeManager().darkTheme,
      home:  ScreenDisplayNotes(),
      routes: {
        ScreenNoteEdit.addRouteName:(context) =>  ScreenNoteEdit(screenMode: ActionType.addNote),
        ScreenNoteEdit.editRouteName:(context) =>  ScreenNoteEdit(screenMode: ActionType.editNote)

      },
    );
  }
}

