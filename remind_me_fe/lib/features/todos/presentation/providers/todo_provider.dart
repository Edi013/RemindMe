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

  _updateCurrentTodosToDisplayWithoutStateUpdate(List<TodoEntity> newList) {
    currentTodosToDisplay = newList;
  }

  Future<List<TodoEntity>> getAllByUserIdTodos(String userId) async {
    var result = await repository.getAllByUserId(userId);
    todos = result;
    _sortAllTodosList();
    _updateCurrentTodosToDisplayWithoutStateUpdate(todos);

    notifyListeners();
    return result;
  }

  Future<List<TodoEntity>> _getAllByUserIdTodosWithoutStateUpdate(
      String userId) async {
    var result = await repository.getAllByUserId(userId);
    todos = result;
    _sortAllTodosList();
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
        await _obtainActiveTodosFromAllTodos(todo.ownerId);
        await _obtainDoneTodosFromAllTodos(todo.ownerId);
        await _obtainUndoneTodosFromAllTodos(todo.ownerId);
        notifyListeners();
      },
    );
  }

  Future<void> update(int index, String listName, TodoEntity todo) async {
    await repository.updateTodo(todo).then(
      (value) async {
        todos[index] = value;
        _sortAllTodosList();
        await _obtainActiveTodosFromAllTodos(todo.ownerId);
        await _obtainDoneTodosFromAllTodos(todo.ownerId);
        await _obtainUndoneTodosFromAllTodos(todo.ownerId);
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
    if (activeTodos.isEmpty) {
      await _getAllByUserIdTodosWithoutStateUpdate(userId);
    }
    await _obtainActiveTodosFromAllTodos(userId);
    _updateCurrentTodosToDisplayWithoutStateUpdate(activeTodos);
    notifyListeners();

    return activeTodos;
  }

  Future<List<TodoEntity>> getUndoneByUserIdTodos(String userId) async {
    if (undoneTodos.isEmpty) {
      await _getAllByUserIdTodosWithoutStateUpdate(userId);
    }
    await _obtainUndoneTodosFromAllTodos(userId);
    _updateCurrentTodosToDisplayWithoutStateUpdate(undoneTodos);

    notifyListeners();

    return undoneTodos;
  }

  Future<List<TodoEntity>> getDoneByUserIdTodos(String userId) async {
    if (doneTodos.isEmpty) {
      await _getAllByUserIdTodosWithoutStateUpdate(userId);
    }
    await _obtainDoneTodosFromAllTodos(userId);
    _updateCurrentTodosToDisplayWithoutStateUpdate(doneTodos);

    notifyListeners();

    return doneTodos;
  }

  Future<void> _obtainActiveTodosFromAllTodos(String userId) async {
    final now = DateTime.now();

    activeTodos = todos
        .where(
            (todo) => todo.startDate.isBefore(now) && todo.endDate.isAfter(now))
        .toList();
  }

  Future<void> _obtainDoneTodosFromAllTodos(String userId) async {
    doneTodos = todos.where((todo) => todo.isFinished == true).toList();
  }

  Future<void> _obtainUndoneTodosFromAllTodos(String userId) async {
    undoneTodos = todos.where((todo) => todo.isFinished == false).toList();
  }
}
