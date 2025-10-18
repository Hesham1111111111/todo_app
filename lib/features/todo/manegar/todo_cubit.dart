import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());
  List<Map> tasks = [];

  String path = "todo.db4";
  Database? database;

  createDatabase() async {
    database = await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE task (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT, image TEXT)',
        );
        print("Table created");
      },
      onOpen: (db) {
        print("Database opened");
        getData();
      },
    );
    emit(TodoCreateDatabase());
  }

  insertTask({
    required String title,
    required String date,
    required String time,
    required String image,
    String status = "new",
  }) async {
    await database!.rawInsert(
      'INSERT INTO task(title, date, time, status, image) VALUES(?, ?, ?, ?, ?)',
      [title, date, time, status, image],
    );
    print("Task inserted");
    getData();
    emit(TodoInsertDatabase());
  }

   getData() async {
    tasks = await database!.rawQuery("SELECT * FROM task");
    emit(TodoGetDatabase());
  }

   deleteTask(int id) async {
    await database!.rawDelete("DELETE FROM task WHERE id = ?", [id]);
    getData();
    emit(TodoDelete());
  }

   updateTask({
    required int id,
    required String title,
    required String date,
    required String time,
    required String image,
  }) async {
    await database!.update(
      'task',
      {'title': title, 'date': date, 'time': time, 'image': image},
      where: 'id = ?',
      whereArgs: [id],
    );
    print("Task updated");
    getData();
    emit(TodoUpdateDatabase());
  }
}
