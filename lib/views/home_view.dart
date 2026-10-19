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
          return Dismissible(
            background: Container(
              color: Colors.red, 
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete, color: Colors.grey,size: 45)),
            ),
            secondaryBackground: Container(
              color: Colors.amberAccent,
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.edit, color: Colors.grey,size: 45),
              ),
            ),
            key: ValueKey(tasks[index]),        
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                setState(() {
                  tasks.remove(tasks[index]); 
                });            
              } else if (direction == DismissDirection.endToStart) {
                Navigator.of(context).pushNamed(notesRoute, arguments: tasks[index]);
              }
            }, 
            child: CheckboxListTile(
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
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed(notesRoute);
          if (result != null){
            setState(() {
              tasks.add(result as Task);
            });
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}