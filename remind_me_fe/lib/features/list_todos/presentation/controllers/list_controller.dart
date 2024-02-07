import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/features/list_todos/presentation/providers/todo_provider.dart';

class TodoListController {
  TodoListController(BuildContext context) {
    getRemoteTodos(context);
  }

  void deleteById(BuildContext context, int id) {
    Provider.of<TodoProvider>(context, listen: false).delete(id);
  }

  Future<void> getRemoteTodos(BuildContext context) async {
    await Provider.of<TodoProvider>(context, listen: false).getAll();
  }
}
