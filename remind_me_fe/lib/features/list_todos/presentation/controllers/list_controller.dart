import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/features/list_todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

class TodoListController {
  late TodoProvider provider;
  TodoListController(BuildContext context) {
    provider = sl<TodoProvider>();
    getRemoteTodos(context);
  }

  void deleteById(BuildContext context, int id) {
    provider.delete(id);
  }

  Future<void> getRemoteTodos(BuildContext context) async {
    await provider.getAll();
  }
}
