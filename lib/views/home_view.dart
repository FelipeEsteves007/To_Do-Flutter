import 'package:flutter/material.dart';
import 'package:appteste/constants/routes.dart';

class Home extends StatefulWidget {
  const new({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> tasks = ['Task 1', 'Task 2', 'Task 3', 'Task 4', 'Task 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white,fontFamily: 'Roboto', fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: tasks.length, 
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${tasks[index]} ', style: const TextStyle(fontSize: 20, fontFamily: 'Roboto', fontWeight: FontWeight.bold)),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).pushNamed(notesRoute);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}