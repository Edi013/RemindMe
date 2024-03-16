import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';

class TodoProvider extends ChangeNotifier {
  late TodoRepositoryImpl repository;
  late List<TodoEntity> todos = [];
  late List<TodoEntity> activeTodos = [];
  late List<TodoEntity> undoneTodos = [];
  late List<TodoEntity> doneTodos = [];

  TodoProvider(TodoRepositoryImpl repo) {
    repository = repo;
  }

  Future<List<TodoEntity>> getAllByUserIdTodos(String userId) async {
    var result = await repository.getAllByUserId(userId);
    todos = result;
    notifyListeners();
    return result;
  }

  Future<void> add(TodoEntity todo) async {
    await repository.addTodo(todo).then((TodoEntity value) {
      todos.add(value);
      notifyListeners();
      obtainActiveTodosFromAllTodos(todo.ownerId);
    });
  }

  Future<void> update(int index, TodoEntity todo) async {
    await repository.updateTodo(todo).then((TodoEntity value) {
      todos[index] = value;
      notifyListeners();
      obtainActiveTodosFromAllTodos(todo.ownerId);
    });
  }

  Future<void> delete(int id) async {
    await repository.deleteTodo(id).then((value) {
      todos.remove(todos.firstWhere((element) => element.id == id));
      notifyListeners();
    });
  }

  Future<List<TodoEntity>> getAllActiveByUserIdTodos(String userId) async {
    var result = await repository.getAllActiveByUserIdTodos(userId);
    activeTodos = result;
    notifyListeners();
    return result;
  }

  Future<List<TodoEntity>> getUndoneByUserIdTodos(String userId) async {
    var result = await repository.getUndoneByUserIdTodos(userId);
    undoneTodos = result;
    notifyListeners();
    return result;
  }

  Future<List<TodoEntity>> getDoneByUserIdTodos(String userId) async {
    var result = await repository.getDoneByUserIdTodos(userId);
    doneTodos = result;
    notifyListeners();
    return result;
  }

  Future<void> obtainActiveTodosFromAllTodos(String userId) async {
    final now = DateTime.now();
    if (todos.isEmpty) {
      await getAllByUserIdTodos(userId);
    }
    activeTodos = todos
        .where(
            (todo) => todo.startDate.isBefore(now) && todo.endDate.isAfter(now))
        .toList();
    notifyListeners();
  }

  Future<void> obtainDoneTodosFromAllTodos(String userId) async {
    if (todos.isEmpty) {
      await getAllByUserIdTodos(userId);
    }
    doneTodos = todos.where((todo) => todo.isFinished == true).toList();
    notifyListeners();
  }

  Future<void> obtainUndoneTodosFromAllTodos(String userId) async {
    if (todos.isEmpty) {
      await getAllByUserIdTodos(userId);
    }
    undoneTodos = todos.where((todo) => todo.isFinished == false).toList();
    notifyListeners();
  }
}
