import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_todos1/providers/todos_provider.dart';

import 'models/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodosProvider(),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todosProvider = Provider.of<TodosProvider>(context, listen: true);
    final todos = todosProvider.todos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(todos[index].description),
          trailing: IconButton(
            onPressed: () {
              todosProvider.delete(todos[index]);
            },
            icon: Icon(
              Icons.remove_circle,
              color: Colors.red.shade300,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final todo = Todo(0, 'todo ${math.Random().nextInt(100)}');
          todosProvider.insert(todo);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
