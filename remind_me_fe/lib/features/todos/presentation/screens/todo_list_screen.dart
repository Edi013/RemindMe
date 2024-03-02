import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/bar/presentation/screen_by_orientation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/features/todos/presentation/screens/todo_list_builder_widget.dart';
import 'package:remind_me_fe/injection_container.dart';

// ignore: must_be_immutable
class TodoListScreen extends StatelessWidget {
  TodoListScreen({super.key}) {
    sl<TodoProvider>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutByOrientation(TodoListScreenContent(context));
  }
}

class TodoListScreenContent extends StatelessWidget {
  const TodoListScreenContent(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await sl<TodoProvider>().getAll();
      },
      child: buildListFromTodos(context, allTodosListName),
    );
  }
}
