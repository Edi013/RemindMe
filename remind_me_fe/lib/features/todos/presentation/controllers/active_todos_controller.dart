import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

List<TodoEntity> getActiveTodos() {
  TodoProvider provider = sl<TodoProvider>();

  return provider.activeTodos;
}
