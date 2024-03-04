import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/bar/presentation/screen_by_orientation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/features/todos/presentation/widgets/todo_list_builder_widget.dart';
import 'package:remind_me_fe/injection_container.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutByOrientation(
      HomeScreenContent(),
    );
  }
}

// ignore: must_be_immutable
class HomeScreenContent extends StatelessWidget {
  TodoProvider provider = sl<TodoProvider>();

  HomeScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          provider.activeTodos.isEmpty ? provider.getAllActiveTodos() : null,
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
                    await sl<TodoProvider>().getAllActiveTodos();
                  },
                  child: buildListFromTodos(context, activeTodosListName),
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
