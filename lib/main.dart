import 'package:flutter/material.dart';
import 'package:flutter_note_app/screens/all_notes_screen/Screen_All_Notes.dart';
import 'package:flutter_note_app/screens/update_or_delete_screen/add_or_update_screen.dart';
import 'package:flutter_note_app/utils/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note-App',
      themeMode: ThemeMode.light,
      theme: ThemeManager().lightTheme,
      darkTheme: ThemeManager().darkTheme,
      home: const ScreenDisplayNotes(),
      routes: {
        ScreenNoteEdit.addRouteName:(context) =>  ScreenNoteEdit(screenMode: ActionType.addNote),
        ScreenNoteEdit.editRouteName:(context) =>  ScreenNoteEdit(screenMode: ActionType.editNote)

      },
    );
  }
}

