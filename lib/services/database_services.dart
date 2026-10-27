import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:appteste/models/task.dart';

class DatabaseServices {

    Future<Database> openDb() async {
        final String dbPath = await getDatabasesPath();
        final String path = join(dbPath, 'tasks.db');

        return await openDatabase(
            path,
            version: 1,
            onCreate: (db, version) async {
                await db.execute('CREATE TABLE TASKS (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, isCompleted INTEGER DEFAULT 0)');
            },
        );
    }

    Future<int> insertTask(Task task) async  {
      final db = await openDb();
      return await db.insert('TASKS', task.toMap());
   }

   Future<int> deleteTask(Task task) async {
      final db = await openDb();

      return await db.delete(
          'TASKS',
          where: "id = ?",
          whereArgs: [task.id]
          );
   }
   
   Future<List<Task>> getAll() async {
     final db = await openDb(); 
     final maps = await db.query('TASKS');
     return maps.map((m) => Task.fromMap(m)).toList();
   }

   Future<int> updateTask(Task task) async {
      final db = await openDb(); 
      return await db.update(
        'TASKS',
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
   }
}