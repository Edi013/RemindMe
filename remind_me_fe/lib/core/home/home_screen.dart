import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/bar/presentation/screen_by_orientation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/features/todos/presentation/screens/todo_list_builder_widget.dart';
import 'package:remind_me_fe/injection_container.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key) {
    sl<TodoProvider>().getAllActiveTodos();
  }

  @override
  Widget build(BuildContext context) {
    return const LayoutByOrientation(HomeScreenContent());
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Hello ${sl<CurrentUser>().nickname}"),
        Flexible(
          child: RefreshIndicator(
            onRefresh: () async {
              sl<TodoProvider>().getAllActiveTodos();
            },
            child: buildListFromTodos(context, activeTodosListName),
          ),
        ),
        const BurgerButton(),
      ],
    );
  }
}
