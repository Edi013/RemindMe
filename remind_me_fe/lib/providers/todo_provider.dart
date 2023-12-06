import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/models/todo_model.dart';
import 'package:remind_me_fe/repositories/to_do_repository.dart';

class ToDoProvider extends ChangeNotifier {
  late ToDoRepository repository;
  late List<ToDo> todos = [];

  ToDoProvider() {
    initialize();
  }

  void initialize() async {
    repository = ToDoRepository();
    todos = await getAll();
    notifyListeners();
  }

  Future<List<ToDo>> getAll() async {
    return await repository.getAll();
  }

  Future<void> add(ToDo object) async {
    await repository.addTodo(object).then((value) {
      todos.add(object);
      notifyListeners();
    });
  }

  Future<void> update(int index, ToDo updatedObject) async {
    await repository.updateTodo(updatedObject).then((value) {
      todos[index] = updatedObject;
      notifyListeners();
    });
  }

  Future<void> delete(int index, ToDo object) async {
    await repository.deleteTodo(object.id!).then((value) {
      todos.removeAt(index);
      notifyListeners();
    });
  }
}
