import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/core/bar/presentation/screen_by_orientation.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:remind_me_fe/features/list_todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/list_todos/presentation/controllers/list_controller.dart';
import 'package:remind_me_fe/features/list_todos/presentation/providers/todo_provider.dart';

// ignore: must_be_immutable
class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutByOrientation(TodoListScreenContent(context));
  }
}

class TodoListScreenContent extends StatelessWidget {
  late TodoListController controller;

  TodoListScreenContent(BuildContext context, {super.key}) {
    controller = TodoListController(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getRemoteTodos(context);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'All tasks',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<TodoProvider>(
                    builder: (context, toDoProvider, child) {
                      return ListView.builder(
                        itemCount: toDoProvider.todos.length,
                        itemBuilder: (context, index) {
                          TodoEntity toDo = toDoProvider.todos[index];
                          return ListTile(
                            title: Text(toDo.title),
                            subtitle: Column(
                              children: [
                                Text("Description: ${toDo.description}"),
                                Text(
                                    "Creation Date: ${toDo.creationDate.toString()}"),
                                Text(
                                    "Start Date: ${toDo.startDate.toString()}"),
                                Text("End Date: ${toDo.endDate.toString()}"),
                                Text(
                                    "Is finished: ${toDo.isFinished.toString()}"),
                                Text(
                                    "Difficulty: ${toDo.difficulty.toString()}"),
                                IconButton(
                                  onPressed: () =>
                                      controller.deleteById(context, toDo.id),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                const Divider()
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.todoUpdateRoute,
                                arguments: {'index': index, 'object': toDo},
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.todoAddRoute);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.75)),
                    ),
                    child: Text(
                      '+',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
