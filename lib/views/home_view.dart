import 'package:flutter/material.dart';
import 'package:appteste/constants/routes.dart';
import 'package:appteste/models/task.dart';
import 'package:appteste/services/database_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Task> tasks = [];

  Future<void> _initDb() async {
    final allTasks = await DatabaseServices().getAll();
    setState(() {
      tasks = allTasks;
    });
  }

  @override
  void initState() {
    _initDb();
    super.initState();
  }

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
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                final newResult = await Navigator.of(context).pushNamed(notesRoute, arguments: tasks[index]);
                  if (newResult is Task){
                    newResult.id = tasks[index].id;
                    newResult.isCompleted = tasks[index].isCompleted;
                    DatabaseServices().updateTask(newResult);
                    setState(() {
                      tasks[index] = newResult;
                    });
                  }
                return false;
              }
              return true;
            },    
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                final deleteNote = tasks[index];
                DatabaseServices().deleteTask(deleteNote);
                setState(() {
                  tasks.remove(deleteNote); 
                });            
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
                DatabaseServices().updateTask(tasks[index]);     
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
          if (result is Task){
            final newId = await DatabaseServices().insertTask(result);
            result.id = newId;
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