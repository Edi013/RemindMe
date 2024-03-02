import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';

class TodoProvider extends ChangeNotifier {
  late TodoRepositoryImpl repository;
  late List<TodoEntity> todos = [];
  late List<TodoEntity> activeTodos = [];

  TodoProvider(TodoRepositoryImpl repo) {
    repository = repo;
    //initialize();
  }

  // void initialize() async {
  //   todos = await getAll();
  //   notifyListeners();
  // }

  Future<List<TodoEntity>> getAll() async {
    var result = await repository.getAll();
    todos = result;
    notifyListeners();
    filterActiveTodos();
    return result;
  }

  Future<List<TodoEntity>> getAllActiveTodos() async {
    var result = await repository.getAllActiveTodos();
    activeTodos = result;
    notifyListeners();
    return result;
  }

  void filterActiveTodos() {
    final now = DateTime.now();
    activeTodos = todos
        .where(
            (todo) => todo.startDate.isBefore(now) && todo.endDate.isAfter(now))
        .toList();
    notifyListeners();
  }

  Future<void> add(TodoEntity object) async {
    await repository.addTodo(object).then((TodoEntity value) {
      todos.add(value);
      notifyListeners();
      filterActiveTodos();
    });
  }

  Future<void> update(int index, TodoEntity updatedObject) async {
    await repository.updateTodo(updatedObject).then((TodoEntity value) {
      todos[index] = value;
      notifyListeners();
      filterActiveTodos();
    });
  }

  Future<void> delete(int id) async {
    await repository.deleteTodo(id).then((value) {
      todos.remove(todos.firstWhere((element) => element.id == id));
      notifyListeners();
      filterActiveTodos();
    });
  }
}
