import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

Scaffold buildListFromTodos(BuildContext context, String todoListName) {
  TodoProvider provider = sl<TodoProvider>();

  List<TodoEntity> todos;
  String title = "";
  switch (todoListName) {
    case allTodosListName:
      todos = provider.todos;
      title = 'All tasks';
      break;
    case activeTodosListName:
      todos = provider.activeTodos;
      title = 'Active tasks';
      break;
    default:
      throw error_message_constants_not_used_list_name;
  }

  return Scaffold(
    body: Container(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, toDoProvider, child) {
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      TodoEntity toDo = todos[index];
                      return ListTile(
                        title: Text(toDo.title),
                        subtitle: Column(
                          children: [
                            Text("Description: ${toDo.description}"),
                            Text(
                                "Creation Date: ${toDo.creationDate.toString()}"),
                            Text("Start Date: ${toDo.startDate.toString()}"),
                            Text("End Date: ${toDo.endDate.toString()}"),
                            Text("Is finished: ${toDo.isFinished.toString()}"),
                            Text("Difficulty: ${toDo.difficulty.toString()}"),
                            IconButton(
                              onPressed: () => provider.delete(toDo.id),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            const Divider()
                          ],
                        ),
                        onTap: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   Routes.todoUpdateRoute,
                          //   arguments: {'index': index, 'object': toDo},
                          // );
                          AutoRouter.of(context).push(const TodoUpdateRoute());
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
                  AutoRouter.of(context).push(const TodoAddRoute());
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context)
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
  );
}
