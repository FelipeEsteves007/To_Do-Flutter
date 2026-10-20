import 'package:flutter/material.dart';
import 'package:appteste/models/task.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final TextEditingController _notesController;
  late final TextEditingController _titleController;
  Object? get message => ModalRoute.of(context)!.settings.arguments;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = message;
    if (args is Task) {
      _titleController.text = args.title;
      _notesController.text = args.description;
    }
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [IconButton(onPressed: () {
          if (_notesController.text.isNotEmpty) {
            Navigator.of(context).pop(Task(title: _titleController.text, description: _notesController.text));
          } else {
            Navigator.of(context).pop();
          }
        }, icon: const Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
                TextField(
                    decoration: InputDecoration(
                      hintText: 'Title...',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blue, width: 2.5),
                      ),
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: _titleController,
                  ),
                  Container(height: 10,),
                  TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your notes here...',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue, width: 2.5),
                  ),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: _notesController,
              ),
          ],
        ),
      )
    );
  }
}