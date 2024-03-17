import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/core/constants.dart';
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
      obtainActiveTodosFromAllTodos(todo.ownerId);
      obtainDoneTodosFromAllTodos(todo.ownerId);
      obtainUndoneTodosFromAllTodos(todo.ownerId);
      notifyListeners();
    });
  }

  Future<void> update(int index, String listName, TodoEntity todo) async {
    await repository.updateTodo(todo).then((TodoEntity value) {
      switch (listName) {
        case allTodosListName:
          todos[index] = value;
          obtainActiveTodosFromAllTodos(todo.ownerId);
          obtainDoneTodosFromAllTodos(todo.ownerId);
          obtainUndoneTodosFromAllTodos(todo.ownerId);
          break;
        case activeTodosListName:
          if (todo.endDate.isAfter(DateTime.now())) {
            activeTodos[index] = value;
          } else {
            activeTodos.remove(
                activeTodos.firstWhere((element) => element.id == value.id));
          }
          todos = [];
          undoneTodos = [];
          doneTodos = [];
          break;
        case undoneTodosListName:
          if (todo.isFinished) {
            undoneTodos.remove(
                undoneTodos.firstWhere((element) => element.id == todo.id));
          } else {
            undoneTodos[index] = value;
          }
          todos = [];
          activeTodos = [];
          doneTodos = [];
          break;
        case doneTodosListName:
          if (!todo.isFinished) {
            doneTodos.remove(
                doneTodos.firstWhere((element) => element.id == todo.id));
          } else {
            doneTodos[index] = value;
          }
          todos = [];
          activeTodos = [];
          undoneTodos = [];
          break;
        default:
          throw error_message_constants_not_used_list_name;
      }
      notifyListeners();
    });
  }

  Future<void> delete(int id) async {
    await repository.deleteTodo(id).then((value) {
      final todoIndex = todos.indexWhere((element) => element.id == id);
      if (todoIndex != -1) {
        todos.removeAt(todoIndex);
      }

      final activeTodoIndex =
          activeTodos.indexWhere((element) => element.id == id);
      if (activeTodoIndex != -1) {
        activeTodos.removeAt(activeTodoIndex);
      }

      final undoneTodoIndex =
          undoneTodos.indexWhere((element) => element.id == id);
      if (undoneTodoIndex != -1) {
        undoneTodos.removeAt(undoneTodoIndex);
      }

      final doneTodoIndex = doneTodos.indexWhere((element) => element.id == id);
      if (doneTodoIndex != -1) {
        doneTodos.removeAt(doneTodoIndex);
      }

      notifyListeners();
    });
  }

  Future<List<TodoEntity>> getActiveByUserIdTodos(String userId) async {
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
