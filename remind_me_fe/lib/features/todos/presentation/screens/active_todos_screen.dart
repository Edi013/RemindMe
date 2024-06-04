import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/layout/presentation/layout_by_orientation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/features/todos/presentation/widgets/todo_list_builder_widget.dart';
import 'package:remind_me_fe/injection_container.dart';

@RoutePage()
class ActiveTodosScreen extends StatelessWidget {
  const ActiveTodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutByOrientation(
      ActiveTodosScreenContent(),
    );
  }
}

// ignore: must_be_immutable
class ActiveTodosScreenContent extends StatelessWidget {
  TodoProvider provider = sl<TodoProvider>();
  CurrentUser currentUser = sl<CurrentUser>();

  ActiveTodosScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: provider.getActiveByUserIdTodos(currentUser.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return buildListFromTodos(context, activeTodosListName);
        }
      },
    );
  }
}
