import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_todos1/models/todo.dart';

class TodosDatabaseHelper {
  static TodosDatabaseHelper _todosDatabaseHelper; // singleton
  static Database _database; // singleton
  final String _todosDatabase = 'todos_database.db';
  final String _todosTable = 'todos';

  TodosDatabaseHelper._internal();

  factory TodosDatabaseHelper() {
    _todosDatabaseHelper ??= TodosDatabaseHelper._internal();
    return _todosDatabaseHelper;
  }

  Future<Database> get database async {
    _database ??= await openDatabase(
      join(
        await getDatabasesPath(),
        _todosDatabase,
      ),
      version: 1,
      onCreate: (db, version) async =>
          db.execute('CREATE TABLE IF NOT EXISTS $_todosTable('
              'id INTEGER PRIMARY KEY, description TEXT)'),
    );
    return _database;
  }

  // CREATE
  Future<void> insert(Todo todo) async {
    final db = await database;
    db.insert(_todosTable, {'description': todo.description});
  }

  // READ
  Future<List<Todo>> todos() async {
    final db = await database;
    final todoMaps = await db.query(_todosTable);
    return todoMaps.map((map) => Todo.fromMap(map)).toList();
  }

  // UPDATE
  Future<void> update(Todo todo) async {
    final db = await database;
    await db.update(_todosTable, todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);
  }

  // DELETE
  Future<void> delete(Todo todo) async {
    final db = await database;
    await db.delete(_todosTable, where: 'id = ?', whereArgs: [todo.id]);
  }
}

class TodosProvider extends ChangeNotifier {
  final TodosDatabaseHelper _databaseHelper = TodosDatabaseHelper();
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  TodosProvider() {
    _databaseHelper.todos().then(
      (todos) {
        _todos = todos;
        notifyListeners();
      },
    );
  }

  void insert(Todo todo) {
    _databaseHelper.insert(todo).then(
          (_) => _databaseHelper.todos().then(
            (todos) {
              _todos = todos;
              notifyListeners();
            },
          ),
        );
  }

  void delete(Todo todo) {
    _databaseHelper.delete(todo).then(
          (_) => _databaseHelper.todos().then(
            (todos) {
              _todos = todos;
              notifyListeners();
            },
          ),
        );
  }
}
