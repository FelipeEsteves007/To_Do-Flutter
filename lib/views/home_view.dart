import 'package:flutter/material.dart';
import 'package:appteste/constants/routes.dart';
import 'package:appteste/models/task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Task> tasks = [];

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
          return CheckboxListTile(
            title: Text(
              tasks[index].title,
              style: TextStyle(
                decoration: tasks[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                fontSize: 23
              ),
            ),
            subtitle: Text(
              tasks[index].description,
              style: TextStyle(
                fontSize: 20  
              )
            ),
            value: tasks[index].isCompleted,
            onChanged: (value) {
              setState(() {
                tasks[index].isCompleted = value ?? false;    
              });            
            },
            checkColor: Colors.white,
            activeColor: Colors.blue,
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          final Task? result = await Navigator.of(context).pushNamed(notesRoute);
          if (result != null){
            setState(() {
              tasks.add(result);
            });
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}