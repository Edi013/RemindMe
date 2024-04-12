import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
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
    case undoneTodosListName:
      todos = provider.undoneTodos;
      title = 'Undone tasks';
      break;
    case doneTodosListName:
      todos = provider.doneTodos;
      title = 'Done tasks';
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
                      TodoEntity todo = todos[index];
                      return SingleChildScrollView(
                        child: ListTile(
                          title: Text(todo.title),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                value: todo.isFinished,
                                onChanged: (value) {
                                  todo.isFinished = !todo.isFinished;
                                  provider.update(
                                    index,
                                    todoListName,
                                    TodoEntity.fromExistent(
                                      id: todo.id,
                                      title: todo.title,
                                      description: todo.description,
                                      creationDate: todo.creationDate,
                                      startDate: todo.startDate,
                                      endDate: todo.endDate,
                                      difficulty: todo.difficulty,
                                      ownerId: todo.ownerId,
                                      isFinished: todo.isFinished,
                                    ),
                                  );
                                },
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Description: \n',
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .merge(
                                              const TextStyle(
                                                fontSize: kFontSize,
                                              ),
                                            ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '${todo.description}',
                                            style: DefaultTextStyle.of(context)
                                                .style
                                                .merge(
                                                  const TextStyle(
                                                    fontSize: kFontSize,
                                                  ),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _buildLineSeparator(),
                                  _buildRichText(
                                      "Creation Date: ${_dateTimeToString(todo.creationDate!)}",
                                      context),
                                  _buildLineSeparator(),
                                  _buildRichText(
                                      "Start Date: ${_dateTimeToString(todo.startDate)}",
                                      context),
                                  _buildLineSeparator(),
                                  _buildRichText(
                                      "End Date: ${_dateTimeToString(todo.endDate)}",
                                      context),
                                  _buildLineSeparator(),
                                  _buildRichText(
                                      "Is finished: ${todo.isFinished.toString()}",
                                      context),
                                  _buildLineSeparator(),
                                  _buildRichText(
                                      "Difficulty: ${todo.difficulty.toString()}",
                                      context),
                                  _buildLineSeparator(),
                                  IconButton(
                                    onPressed: () => provider.delete(todo.id),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const Divider()
                                ],
                              ),
                              const SizedBox()
                            ],
                          ),
                          onTap: () {
                            AutoRouter.of(context).push(TodoUpdateRoute(
                                index: index,
                                todoId: todo.id,
                                listName: todoListName));
                          },
                        ),
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
                child: const Text('+'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

_buildLineSeparator() {
  const double height = 10;
  return const SizedBox(height: height);
}

Widget _buildRichText(String text, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width / 1.7,
    child: RichText(
      text: TextSpan(
        text: text,
        style: DefaultTextStyle.of(context).style.merge(
              const TextStyle(
                fontSize: kFontSize,
              ),
            ),
      ),
    ),
  );
}

String _dateTimeToString(DateTime dateTime) {
  return '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}';
}
