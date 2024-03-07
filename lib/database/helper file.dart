import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Task {
  final int id;
  final String title;
  final bool status;

  Task({
    required this.id,
    required this.title,
    required this.status,
  });
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            status INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert(
      'tasks',
      {'id': task.id, 'title': task.title, 'status': task.status ? 1 : 0},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        title: maps[index]['title'],
        status: maps[index]['status'] == 1,
      );
    });
  }

  Future<void> updateTaskStatus(int id, bool newStatus) async {
    final db = await database;
    await db.update(
      'tasks',
      {'status': newStatus ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Toggle Status Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TaskDetails(),
        ),
      ),
    );
  }
}

class TaskDetails extends StatefulWidget {
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: dbHelper.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No tasks available.');
        } else {
          Task task = snapshot.data!.first;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task Title: ${task.title}'),
              Text('Task Status: ${task.status ? 'Completed' : 'Pending'}'),
              ElevatedButton(
                onPressed: () {
                  // Toggle the status when the button is pressed
                  dbHelper.updateTaskStatus(task.id, !task.status);
                  // Refresh the UI
                  setState(() {});
                },
                child: Text('Toggle Status'),
              ),
            ],
          );
        }
      },
    );
  }
}
