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
                          title: _buildRichTextForTitle(
                            context: context,
                            title: todo.title,
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildCheckboxForTodo(
                                  todo, provider, index, todoListName),
                              const SizedBox(width: 30),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // _buildRichTextForDescription(context,
                                  //     'Description: \n', todo.description),
                                  Container(
                                    constraints: BoxConstraints(
                                        maxHeight: double.infinity,
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    child: Text(
                                      "Description: \n ${todo.description}",
                                      style: TextStyle(
                                        fontSize: kFontSize,
                                      ),
                                      maxLines: null,
                                    ),
                                  ),

                                  _buildLineSeparator(),
                                  _buildRichTextForField(
                                      context: context,
                                      title: "Creation Date: ",
                                      content: _dateTimeToString(
                                          todo.creationDate!)),
                                  _buildLineSeparator(),
                                  _buildRichTextForField(
                                      context: context,
                                      title: "Start Date: ",
                                      content:
                                          _dateTimeToString(todo.startDate)),
                                  _buildLineSeparator(),
                                  _buildRichTextForField(
                                      context: context,
                                      title: "End Date: ",
                                      content: _dateTimeToString(todo.endDate)),
                                  _buildLineSeparator(),
                                  _buildRichTextForField(
                                      context: context,
                                      title: "Is finished: ",
                                      content: todo.isFinished ? 'Yes' : 'No'),
                                  _buildLineSeparator(),
                                  _buildRichTextForField(
                                      context: context,
                                      title: "Difficulty: ",
                                      content: todo.difficulty.toString()),
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
            _buildAddButton(context),
          ],
        ),
      ),
    ),
  );
}

_buildAddButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ElevatedButton(
      onPressed: () {
        AutoRouter.of(context).push(const TodoAddRoute());
      },
      child: const Text('+'),
    ),
  );
}

_buildCheckboxForTodo(
    final todo, final provider, final index, final todoListName) {
  return Checkbox(
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
  );
}

_buildRichTextForDescription(
    BuildContext context, String title, String content) {
  return RichText(
    text: TextSpan(
      text: title,
      style: DefaultTextStyle.of(context).style.merge(
            const TextStyle(
              fontSize: kFontSize,
            ),
          ),
      children: <TextSpan>[
        TextSpan(
          text: content,
          style: DefaultTextStyle.of(context).style.merge(
                const TextStyle(
                  fontSize: kFontSize,
                ),
              ),
        ),
      ],
    ),
    maxLines: null,
  );
}

_buildLineSeparator() {
  const double height = 10;
  return const SizedBox(height: height);
}

Widget _buildRichTextForField(
    {required BuildContext context,
    required String title,
    String content = ""}) {
  return Container(
    //width: MediaQuery.of(context).size.width / 1.7,
    child: RichText(
      text: TextSpan(
        text: title,
        style: DefaultTextStyle.of(context).style.merge(
              const TextStyle(
                fontSize: kFontSize,
              ),
            ),
        children: <TextSpan>[
          TextSpan(
            text: content,
            style: DefaultTextStyle.of(context).style.merge(
                  const TextStyle(
                    fontSize: kFontSize,
                  ),
                ),
          ),
        ],
      ),
      maxLines: null,
    ),
  );
}

Widget _buildRichTextForTitle({
  required BuildContext context,
  required String title,
}) {
  return Container(
    //width: MediaQuery.of(context).size.width / 1.7,
    child: RichText(
      text: TextSpan(
        text: title,
        style: DefaultTextStyle.of(context).style.merge(
              const TextStyle(
                fontSize: kFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      maxLines: null,
    ),
  );
}

String _dateTimeToString(DateTime dateTime) {
  return '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}';
}
