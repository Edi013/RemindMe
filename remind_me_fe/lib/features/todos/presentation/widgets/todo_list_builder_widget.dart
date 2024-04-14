import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                //List<TodoEntity> todos = todoProvider.todos;
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

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '$title (${todos.length})',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, toDoProvider, child) {
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      TodoEntity todo = todos[index];
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildRichTextForTitle(
                              context: context,
                              title: todo.title,
                            ),
                            _buildCheckboxForTodo(
                                todo, provider, index, todoListName),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRichTextForDescription(context,
                                    'Description: \n', todo.description),
                                _buildLineSeparator(),
                                _buildRichTextForField(
                                    context: context,
                                    title: "Creation Date: ",
                                    content:
                                        _dateTimeToString(todo.creationDate!)),
                                _buildLineSeparator(),
                                _buildRichTextForField(
                                    context: context,
                                    title: "Start Date: ",
                                    content: _dateTimeToString(todo.startDate)),
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
                                //const Divider()
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
    TodoEntity todo, TodoProvider provider, int index, String todoListName) {
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

Widget _buildRichTextForDescription(
  BuildContext context,
  String title,
  String content,
) {
  return Container(
    constraints: BoxConstraints(
      maxWidth:
          MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
              ? _buildWidthForLandscapeOrientation(
                  context, MediaQuery.of(context).size.width)
              : _buildWidthForPortraitOrientation(
                  context, MediaQuery.of(context).size.width),
    ),
    child: MarkdownBody(
      data: content,
      styleSheet: MarkdownStyleSheet(
        p: const TextStyle(fontSize: kFontSize),
      ),
    ),
  );
}

_buildWidthForPortraitOrientation(BuildContext context, double width) {
  if (width >= 1 && width < 300) {
    return MediaQuery.of(context).size.width * 0.55;
  } else if (width > 300 && width < 500) {
    return MediaQuery.of(context).size.width * 0.65;
  } else if (width >= 500 && width < 700) {
    return MediaQuery.of(context).size.width * 0.7;
  } else if (width >= 700 && width < 800) {
    return MediaQuery.of(context).size.width * 0.75;
  } else if (width >= 800 && width < 900) {
    return MediaQuery.of(context).size.width * 0.8;
  } else if (width >= 900 && width < 1100) {
    return MediaQuery.of(context).size.width * 0.85;
  } else if (width >= 1100 && width < 1300) {
    return MediaQuery.of(context).size.width * 0.85;
  } else if (width >= 1300 && width < 1500) {
    return MediaQuery.of(context).size.width * 0.85;
  } else if (width >= 1500 && width < 1800) {
    return MediaQuery.of(context).size.width * 0.85;
  } else if (width >= 1800 && width < 2000) {
    return MediaQuery.of(context).size.width * 0.85;
  } else {
    return MediaQuery.of(context).size.width * 0.9;
  }
}

_buildWidthForLandscapeOrientation(BuildContext context, width) {
  if (width >= 1 && width < 300) {
    return MediaQuery.of(context).size.width * 0.2;
  } else if (width > 300 && width < 500) {
    return MediaQuery.of(context).size.width * 0.3;
  } else if (width >= 500 && width < 700) {
    return MediaQuery.of(context).size.width * 0.4;
  } else if (width >= 700 && width < 800) {
    return MediaQuery.of(context).size.width * 0.45;
  } else if (width >= 800 && width < 900) {
    return MediaQuery.of(context).size.width * 0.5;
  } else if (width >= 900 && width < 1100) {
    return MediaQuery.of(context).size.width * 0.55;
  } else if (width >= 1100 && width < 1300) {
    return MediaQuery.of(context).size.width * 0.65;
  } else if (width >= 1300 && width < 1500) {
    return MediaQuery.of(context).size.width * 0.7;
  } else if (width >= 1500 && width < 1800) {
    return MediaQuery.of(context).size.width * 0.7;
  } else if (width >= 1800 && width < 2000) {
    return MediaQuery.of(context).size.width * 0.75;
  } else {
    return MediaQuery.of(context).size.width * 0.8;
  }
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
  return '${dateTime.year}-${_avoidSingleDigid(dateTime.month)}-${_avoidSingleDigid(dateTime.day)} ${_avoidSingleDigid(dateTime.hour)}:${_avoidSingleDigid(dateTime.minute)}';
}

String _avoidSingleDigid(int value) {
  return '${value < 10 ? '0$value' : value}';
}

class MarkdownTextField extends StatefulWidget {
  @override
  _MarkdownTextFieldState createState() => _MarkdownTextFieldState();
}

class _MarkdownTextFieldState extends State<MarkdownTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markdown TextField Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Input text here',
                contentPadding: EdgeInsets.all(16.0),
              ),
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Markdown(
                  data:
                      '""" # Flutter Markdown Example\n\nThis is an example of how to use the `flutter_markdown` package in a Flutter app.\n\n- It supports basic text formatting like *italic* and **bold**.\n- You can create lists:\n  1. Item 1\n  2. Item 2\n- Links are clickable: [OpenAI](https://www.openai.com)\n\n## Give it a try!\n\nYou can experiment with different Markdown content here.\n"""',

                  //data: _controller.text,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
