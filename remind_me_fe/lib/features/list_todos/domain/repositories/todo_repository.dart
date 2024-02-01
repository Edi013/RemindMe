import 'package:remind_me_fe/features/list_todos/domain/entities/todo.dart';

abstract class ToDoRepository {
  Future<List<TodoEntity>> getAll();
  Future<TodoEntity> addTodo(TodoEntity todo);
  Future<TodoEntity> updateTodo(TodoEntity updatedToDo);
  Future<void> deleteTodo(int todoId);
}
