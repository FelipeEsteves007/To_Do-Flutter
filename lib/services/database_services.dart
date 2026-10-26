import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
}