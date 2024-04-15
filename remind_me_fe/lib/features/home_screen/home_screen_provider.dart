import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/todos/presentation/screens/active_todos_screen.dart';
import 'package:remind_me_fe/features/todos/presentation/screens/all_todos_screens/todo_list_screen.dart';
import 'package:remind_me_fe/features/todos/presentation/screens/done_todos_screen.dart';
import 'package:remind_me_fe/features/todos/presentation/screens/undone_todos_screen.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenProvider extends ChangeNotifier {
  late String _defaultScreenName;
  late SharedPreferences preferences;

  HomeScreenProvider() {
    init();
  }

  init() {
    preferences = sl<SharedPreferences>();

    final existingValue =
        preferences.getString(selectedScreenSharedPreferances);
    existingValue == null
        ? changeDefaultScreen(activeTodosScreen)
        : changeDefaultScreen(existingValue);
  }

  Widget loadSelectedDefaultScreen() {
    switch (_defaultScreenName) {
      case allTodosScreen:
        return const TodoListScreen();
      case activeTodosScreen:
        return const ActiveTodosScreen();
      case undoneTodosScreen:
        return const UndoneTodosScreen();
      case doneTodosScreen:
        return const DoneTodosScreen();
      default:
        throw error_message_constants_not_used_screen_name;
    }
  }

  void changeDefaultScreen(String newDefaultScreen) {
    switch (newDefaultScreen) {
      case allTodosScreen:
        _defaultScreenName = newDefaultScreen;
        break;
      case activeTodosScreen:
        _defaultScreenName = newDefaultScreen;
        break;
      case undoneTodosScreen:
        _defaultScreenName = newDefaultScreen;
        break;
      case doneTodosScreen:
        _defaultScreenName = newDefaultScreen;
        break;
      default:
        throw error_message_constants_not_used_screen_name;
    }

    preferences.setString(selectedScreenSharedPreferances, newDefaultScreen);
  }
}
