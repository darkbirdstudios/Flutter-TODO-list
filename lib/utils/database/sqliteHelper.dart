import 'package:flutter_todo_list_sqlit/utils/model/TaskModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider dataBase = DBProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDataBase();
    return _database;
  }

  initDataBase() async {
    return await openDatabase(join(await getDatabasesPath(), 'task.db'),
        onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, creationTime TEXT , priority INTEGER)
      ''');
    }, version: 1);
  }

  addTask(Task newTask) async{
    final db = await database;
    db!.insert("tasks", newTask.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  updateTask(Task newTask) async{
    final db = await database;
    print(newTask.toMap().values.toString());
    await db!.update("tasks", newTask.toMap(),where: 'id == ?',whereArgs: [newTask.id]);
  }

  Future<dynamic> deleteTask(id) async{
    final db = await database;
    await db!.delete("tasks",where: 'id == ?',whereArgs: [id]);
  }

  Future<dynamic> getTask() async{
    final db = await database;
    var result = await db!.query("tasks",orderBy: 'id DESC');
    if(result.length == 0){
      return null;
    }else{
      var resultMap = result.toList();
      return resultMap.isNotEmpty?resultMap:null;
    }
  }
}
