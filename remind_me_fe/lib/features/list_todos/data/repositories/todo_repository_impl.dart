import 'package:remind_me_fe/features/list_todos/data/data_sources/remote/todo_service_api.dart';
import 'package:remind_me_fe/features/list_todos/data/models/todo.dart';
import 'package:remind_me_fe/features/list_todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/list_todos/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements ToDoRepository {
  late TodoServiceApi _todoServiceApi;

  TodoRepositoryImpl(TodoServiceApi todoServiceApi) {
    _todoServiceApi = todoServiceApi;
  }

  @override
  Future<List<TodoEntity>> getAll() async {
    List<TodoModel> remoteData = await _todoServiceApi.getAll();
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
