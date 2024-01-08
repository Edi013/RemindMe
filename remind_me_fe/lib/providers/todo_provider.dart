import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/models/todo_model.dart';
import 'package:remind_me_fe/repositories/to_do_repository.dart';

class ToDoProvider extends ChangeNotifier {
  late ToDoRepository repository;
  late List<ToDo> todos = [];

  ToDoProvider.singleton() {
    initialize();
  }

  static final ToDoProvider _instance = ToDoProvider.singleton();

  static ToDoProvider get instance => _instance;

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
      todos.add(value);
      notifyListeners();
    });
  }

  Future<void> update(int index, ToDo updatedObject) async {
    await repository.updateTodo(updatedObject).then((value) {
      todos[index] = value;
      notifyListeners();
    });
  }

  Future<void> delete(int id) async {
    await repository.deleteTodo(id).then((value) {
      todos.remove(todos.firstWhere((element) => element.id == id));
      notifyListeners();
    });
  }
}
