import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';

class TodoProvider extends ChangeNotifier {
  late TodoRepositoryImpl repository;
  late List<TodoEntity> todos = [];
  late List<TodoEntity> activeTodos = [];
  late List<TodoEntity> undoneTodos = [];
  late List<TodoEntity> doneTodos = [];
  late List<TodoEntity> currentTodosToDisplay = [];

  TodoProvider(TodoRepositoryImpl repo) {
    repository = repo;
  }

  updateCurrentTodosToDisplay(List<TodoEntity> newList) {
    currentTodosToDisplay = newList;
    notifyListeners();
  }

  Future<List<TodoEntity>> getAllByUserIdTodos(String userId) async {
    var result = await repository.getAllByUserId(userId);
    todos = result;
    _sortAllTodosList();
    notifyListeners();
    return result;
  }

  _sortAllTodosList() {
    todos.sort(((a, b) => b.creationDate!.compareTo(a.creationDate!)));
  }

  Future<void> add(TodoEntity todo) async {
    await repository.addTodo(todo).then(
      (value) async {
        todos.add(value);
        _sortAllTodosList();
        await obtainActiveTodosFromAllTodos(todo.ownerId);
        await obtainDoneTodosFromAllTodos(todo.ownerId);
        await obtainUndoneTodosFromAllTodos(todo.ownerId);
        notifyListeners();
      },
    );
  }

  Future<void> update(int index, String listName, TodoEntity todo) async {
    await repository.updateTodo(todo).then(
      (value) async {
        todos[index] = value;
        _sortAllTodosList();
        await obtainActiveTodosFromAllTodos(todo.ownerId);
        await obtainDoneTodosFromAllTodos(todo.ownerId);
        await obtainUndoneTodosFromAllTodos(todo.ownerId);
        notifyListeners();
      },
    );
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
    await getAllByUserIdTodos(userId);
    await obtainActiveTodosFromAllTodos(userId);
    return activeTodos;
  }

  Future<List<TodoEntity>> getUndoneByUserIdTodos(String userId) async {
    await getAllByUserIdTodos(userId);
    await obtainUndoneTodosFromAllTodos(userId);
    return undoneTodos;
  }

  Future<List<TodoEntity>> getDoneByUserIdTodos(String userId) async {
    await getAllByUserIdTodos(userId);
    await obtainDoneTodosFromAllTodos(userId);
    return doneTodos;
  }

  Future<void> obtainActiveTodosFromAllTodos(String userId) async {
    final now = DateTime.now();

    activeTodos = todos
        .where(
            (todo) => todo.startDate.isBefore(now) && todo.endDate.isAfter(now))
        .toList();
    notifyListeners();
  }

  Future<void> obtainDoneTodosFromAllTodos(String userId) async {
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
