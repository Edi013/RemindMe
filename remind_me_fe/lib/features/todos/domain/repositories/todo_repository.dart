import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';

abstract class ToDoRepository {
  Future<List<TodoEntity>> getAllByUserId(String userId);
  Future<List<TodoEntity>> getActiveByUserIdTodos(String userId);
  Future<List<TodoEntity>> getDoneByUserIdTodos(String userId);
  Future<List<TodoEntity>> getUndoneByUserIdTodos(String userId);
  Future<TodoEntity> addTodo(TodoEntity todo);
  Future<TodoEntity> updateTodo(TodoEntity updatedToDo);
  Future<void> deleteTodo(int todoId);
}
