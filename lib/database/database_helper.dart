import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openMyDatabase() async {
  return await openDatabase(join(await getDatabasesPath(), 'myToDoDatabase.db'),
      version: 1, onCreate: (db, version) async {
    await db.execute(
        'CREATE TABLE todoList(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, description TEXT, tag TEXT, status  INTEGER, date INTEGER, month TEXT)');
  });
}

Future<void> insertList(title, description, tag, date, month) async {
  final db = await openMyDatabase();
  await db.insert(
    'todoList',
    {
      'title': title,
      'description': description,
      'tag': tag,
      'status': 0,
      'date': date,
      'month': month,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Map<String, dynamic>>> getLists() async {
  final db = await openMyDatabase();
  final rows = await db.query('todoList');
  return rows;
}

Future<List<Map<String, dynamic>>> getList(int status) async {
  final db = await openMyDatabase();
  final rows = db.query('todoList', where: "status = ?", whereArgs: [status]);
  return rows;
}

Future<List<Map<String, dynamic>>> getListByDate(int status, int date) async {
  final db = await openMyDatabase();
  final rows = db.query('todoList', where: "status = ? AND date = ?", whereArgs: [status, date]);
  return rows;
}

Future<void> deleteList(id) async {
  final db = await openMyDatabase();
  db.delete(
    'todoList',
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future deleteTable() async {
  final db = await openMyDatabase();
  db.delete('todoList');
}

Future<void> updateList(id, title, description, tag) async {
  final db = await openMyDatabase();
  db.update(
    'todoList',
    {
      'title': title,
      'description': description,
      'tag': tag,
    },
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> updateStatus(id, status) async {
  final db = await openMyDatabase();
  db.update(
    'todoList',
    {
      'status': status,
    },
    where: "id = ?",
    whereArgs: [id],
  );
}

Future<int> getRowCountByDate(status, date)async{
  final db = await openMyDatabase();
  final result = await db.rawQuery('SELECT COUNT(*) FROM todoList WHERE status = ? AND date = ?', [status, date]);
  final int count = Sqflite.firstIntValue(result) ?? 0;
  return count ;
}

Future<int> getRowCount(status)async{
  final db = await openMyDatabase();
  final result = await db.rawQuery('SELECT COUNT(*) FROM todoList WHERE status = ?', [status]);
  final int count = Sqflite.firstIntValue(result) ?? 0;
  return count ;
}

Future getOverdueList(status, date) async{
  final db = await openMyDatabase();
  final result = await db.rawQuery('SELECT * FROM todoList WHERE status = ? AND date != ?', [status, date]);
  return result;
}

Future<int> getOverdueListCount(status, date) async{
  final db = await openMyDatabase();
  final result = await db.rawQuery('SELECT COUNT(*) FROM todoList WHERE status = ? AND date != ?', [status, date]);
  final int count = Sqflite.firstIntValue(result) ?? 0;
  return count ;
}