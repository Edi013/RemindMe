import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/models/todo_model.dart';
import 'package:remind_me_fe/repositories/to_do_repository.dart';

class ToDoProvider extends ChangeNotifier {
  late ToDoRepository repository;
  late List<ToDo> todos = [];

  ToDoProvider() {
    repository = ToDoRepository();
    initialize();
  }

  void initialize() async {
    todos = await getAll();
    notifyListeners();
  }

  Future<List<ToDo>> getAll() async {
    return await repository.getAll();
  }

  Future<void> add(ToDo object) async {
    todos.add(object);
    await repository.addTodo(object);
    notifyListeners();
  }

  Future<void> update(int index, ToDo updatedObject) async {
    todos[index] = updatedObject;
    await repository.updateTodo(updatedObject);
    notifyListeners();
  }

  Future<void> delete(int index, ToDo object) async {
    todos.removeAt(index);
    await repository.deleteTodo(object.id!);
  }
}
