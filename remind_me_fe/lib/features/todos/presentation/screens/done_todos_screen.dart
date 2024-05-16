import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/layout/presentation/layout_by_orientation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/features/todos/presentation/widgets/todo_list_builder_widget.dart';
import 'package:remind_me_fe/injection_container.dart';

@RoutePage()
class DoneTodosScreen extends StatelessWidget {
  const DoneTodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutByOrientation(
      DoneTodosScreenContent(),
    );
  }
}

class DoneTodosScreenContent extends StatelessWidget {
  TodoProvider provider = sl<TodoProvider>();
  CurrentUser currentUser = sl<CurrentUser>();

  DoneTodosScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: provider.getDoneByUserIdTodos(currentUser.id!),
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
                    await sl<TodoProvider>()
                        .getDoneByUserIdTodos(currentUser.id!);
                  },
                  child: buildListFromTodos(context, doneTodosListName),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
