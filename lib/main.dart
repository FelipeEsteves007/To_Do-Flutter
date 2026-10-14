import 'package:flutter/material.dart';
import 'package:appteste/constants/routes.dart';
import 'package:appteste/views/home_view.dart';
import 'package:appteste/views/notes_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'To-Do App',
    home: const Home(),
    routes: {
      homeRoute: (context) => const Home(),
      notesRoute: (context) => const NotesView(),
    }
  ));
}
