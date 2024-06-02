import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:remind_me_fe/core/theme/theme_config.dart';
import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

List<TodoEntity> getTodosToDisplay(String todoListName, TodoProvider provider) {
  switch (todoListName) {
    case allTodosListName:
      return provider.todos;
    case activeTodosListName:
      return provider.activeTodos;
    case undoneTodosListName:
      return provider.undoneTodos;
    case doneTodosListName:
      return provider.doneTodos;
    default:
      throw error_message_constants_not_used_list_name;
  }
}

String getTitleForListName(String todoListName) {
  switch (todoListName) {
    case allTodosListName:
      return 'All tasks';
    case activeTodosListName:
      return 'Active tasks';
    case undoneTodosListName:
      return 'Tasks not finished';
    case doneTodosListName:
      return 'Finished tasks';
    default:
      throw error_message_constants_not_used_list_name;
  }
}

List<TodoEntity> filterTodosListByTitle(
    List<TodoEntity> listToFilter, String stringToSearchFor) {
  return listToFilter
      .where((element) =>
          element.title.toLowerCase().contains(stringToSearchFor.toLowerCase()))
      .toList();
}

int findIndexForTaskByListName(todo, todoListName, provider) {
  return getTodosToDisplay(todoListName, provider).indexOf(todo);
}

Scaffold buildListFromTodos(BuildContext context, String todoListName) {
  TodoProvider provider = sl<TodoProvider>();
  final TextEditingController searchTextFieldController =
      TextEditingController();

  String title = getTitleForListName(todoListName);
  provider
      .updateCurrentTodosToDisplay(getTodosToDisplay(todoListName, provider));

  return Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImagePath),
          fit: BoxFit.fill,
        ),
      ),
      child: Card(
        color: Colors.black.withOpacity(0.7),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 2),
              child: Text(
                'Task finder',
                style: TextStyle(
                  fontSize: kHeadingMediumFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
              child: TextFormField(
                controller: searchTextFieldController,
                decoration: const InputDecoration(
                    // sa i fac culoarea alba
                    focusColor: Colors.red,
                    labelText: 'Enter task title',
                    icon: Icon(Icons.search)),
                onChanged: (value) {
                  provider.updateCurrentTodosToDisplay(
                    filterTodosListByTitle(
                        getTodosToDisplay(todoListName, provider), value),
                  );
                },
              ),
            ),
            Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '$title (${provider.currentTodosToDisplay.length})',
                    style: const TextStyle(
                      fontSize: kHeadingMediumFontSize,
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
                    itemCount: provider.currentTodosToDisplay.length,
                    itemBuilder: (context, index) {
                      TodoEntity todo = provider.currentTodosToDisplay[index];
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildRichTextForTitle(
                              context: context,
                              title: todo.title,
                            ),
                            _buildCheckboxForTodo(
                              todo,
                              todoListName,
                              provider,
                              index,
                              searchTextFieldController.text,
                            )
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
                                const Divider(),
                                _buildRichTextForDescription(context,
                                    'Description: \n', todo.description),
                                const Divider(),
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
                                  onPressed: () async {
                                    await provider.delete(todo.id);
                                    await provider.updateCurrentTodosToDisplay(
                                      filterTodosListByTitle(
                                          getTodosToDisplay(
                                              todoListName, provider),
                                          searchTextFieldController.text),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                const Divider(color: white),
                              ],
                            ),
                          ],
                        ),
                        onTap: () async {
                          int taskIndexForInitialList = index;
                          if (searchTextFieldController.text.isNotEmpty) {
                            taskIndexForInitialList =
                                findIndexForTaskByListName(
                                    todo, todoListName, provider);
                          }

                          await AutoRouter.of(context).push(
                            TodoUpdateRoute(
                                index: taskIndexForInitialList,
                                todoId: todo.id,
                                listName: todoListName),
                          );

                          await provider.updateCurrentTodosToDisplay(
                            filterTodosListByTitle(
                                getTodosToDisplay(todoListName, provider),
                                searchTextFieldController.text),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            _buildAddButton(
              () async {
                await AutoRouter.of(context).push(const TodoAddRoute());

                await provider.updateCurrentTodosToDisplay(
                  filterTodosListByTitle(
                      getTodosToDisplay(todoListName, provider),
                      searchTextFieldController.text),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

_buildAddButton(Function() onPressed) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ElevatedButton(
      onPressed: onPressed,
      child: const Text('+'),
    ),
  );
}

_buildCheckboxForTodo(TodoEntity todo, String todoListName,
    TodoProvider provider, int index, String searchTextFieldControllerText) {
  return Checkbox(
    value: todo.isFinished,
    onChanged: (value) async {
      todo.isFinished = !todo.isFinished;

      int taskIndexForInitialList = index;
      if (searchTextFieldControllerText.isNotEmpty) {
        taskIndexForInitialList =
            findIndexForTaskByListName(todo, todoListName, provider);
      }

      await provider.update(
        taskIndexForInitialList,
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

      await provider.updateCurrentTodosToDisplay(
        filterTodosListByTitle(getTodosToDisplay(todoListName, provider),
            searchTextFieldControllerText),
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
        h1: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        h2: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
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

Widget _buildRichTextForTitle({
  required BuildContext context,
  required String title,
}) {
  return RichText(
    text: TextSpan(
      text: title,
      style: DefaultTextStyle.of(context).style.merge(
            const TextStyle(
              fontSize: kFontSize * 1.4,
              fontWeight: FontWeight.bold,
            ),
          ),
    ),
    maxLines: null,
  );
}

String _dateTimeToString(DateTime dateTime) {
  return '${dateTime.year}-${_avoidSingleDigit(dateTime.month)}-${_avoidSingleDigit(dateTime.day)} ${_avoidSingleDigit(dateTime.hour)}:${_avoidSingleDigit(dateTime.minute)}';
}

String _avoidSingleDigit(int value) {
  return '${value < 10 ? '0$value' : value}';
}
