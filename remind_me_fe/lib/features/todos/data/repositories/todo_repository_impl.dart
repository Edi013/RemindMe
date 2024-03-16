import 'package:remind_me_fe/features/todos/data/data_sources/remote/todo_service_api.dart';
import 'package:remind_me_fe/features/todos/data/models/todo.dart';
import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/todos/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements ToDoRepository {
  late TodoServiceApi _todoServiceApi;

  TodoRepositoryImpl(TodoServiceApi todoServiceApi) {
    _todoServiceApi = todoServiceApi;
  }

  @override
  Future<List<TodoEntity>> getAllByUserId(String userId) async {
    List<TodoModel> remoteData = await _todoServiceApi.getAllByUserId(userId);
    return remoteData.map((todoModel) {
      return todoModel.toTodoEntity();
    }).toList();
  }

  @override
  Future<List<TodoEntity>> getAllActiveByUserIdTodos(String userId) async {
    List<TodoModel> remoteData =
        await _todoServiceApi.getAllByUserIdActiveTodos(userId);
    return remoteData.map((todoModel) {
      return todoModel.toTodoEntity();
    }).toList();
  }

  @override
  Future<List<TodoEntity>> getUndoneByUserIdTodos(String userId) async {
    List<TodoModel> remoteData =
        await _todoServiceApi.getUndoneByUserIdTodos(userId);
    return remoteData.map((todoModel) {
      return todoModel.toTodoEntity();
    }).toList();
  }

  @override
  Future<List<TodoEntity>> getDoneByUserIdTodos(String userId) async {
    List<TodoModel> remoteData =
        await _todoServiceApi.getDoneByUserIdTodos(userId);
    return remoteData.map((todoModel) {
      return todoModel.toTodoEntity();
    }).toList();
  }

  @override
  Future<void> deleteTodo(int todoId) async {
    await _todoServiceApi.deleteTodo(todoId);
  }

  @override
  Future<TodoEntity> addTodo(TodoEntity todo) async {
    TodoModel remoteData =
        await _todoServiceApi.addTodo(TodoModel.fromTodoEntity(todo));
    return remoteData.toTodoEntity();
  }

  @override
  Future<TodoEntity> updateTodo(TodoEntity updatedToDo) async {
    TodoModel remoteData =
        await _todoServiceApi.updateTodo(TodoModel.fromTodoEntity(updatedToDo));
    return remoteData.toTodoEntity();
  }
}
