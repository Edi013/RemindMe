import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/bar/presentation/screen_by_orientation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/features/todos/presentation/screens/todo_list_builder_widget.dart';
import 'package:remind_me_fe/injection_container.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LayoutByOrientation(
      TodoListScreenContent(),
    );
  }
}

class TodoListScreenContent extends StatelessWidget {
  const TodoListScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl<TodoProvider>().getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Row(
            children: [
              Flexible(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await sl<TodoProvider>().getAll();
                  },
                  child: buildListFromTodos(context, allTodosListName),
                ),
              ),
              const BurgerButton(),
            ],
          );
        }
      },
    );
  }
}
