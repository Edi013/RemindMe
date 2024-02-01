import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/features/list_todos/data/repositories/todo_repository_impl.dart';
import 'package:remind_me_fe/features/list_todos/domain/entities/todo.dart';
import 'package:remind_me_fe/injection_container.dart';

class TodoProvider extends ChangeNotifier {
  late TodoRepositoryImpl repository;
  late List<TodoEntity> todos = [];

  TodoProvider() {
    initialize();
  }

  void initialize() async {
    repository = sl<TodoRepositoryImpl>();
    todos = await getAll();
    notifyListeners();
  }

  Future<List<TodoEntity>> getAll() async {
    var result = await repository.getAll();
    return result;
  }

  Future<void> add(TodoEntity object) async {
    await repository.addTodo(object).then((TodoEntity value) {
      todos.add(value);
      notifyListeners();
    });
  }

  Future<void> update(int index, TodoEntity updatedObject) async {
    await repository.updateTodo(updatedObject).then((TodoEntity value) {
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
