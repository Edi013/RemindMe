import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/models/todo_model.dart';
import 'package:remind_me_fe/repositories/to_do_repository.dart';

class ToDoProvider extends ChangeNotifier {
  late ToDoRepository repository;
  late List<ToDo> _todos;

  List<ToDo> get todos => _todos;

  ToDoProvider() {
    repository = ToDoRepository();
    getAll();
  }

  void getAll() async {
    _todos = await repository.getAll();
    notifyListeners();
  }

  void add(ToDo object) {
    _todos.add(object);
    notifyListeners();
  }

  void update(int index, ToDo updatedObject) {
    _todos[index] = updatedObject;
    notifyListeners();
  }
}
