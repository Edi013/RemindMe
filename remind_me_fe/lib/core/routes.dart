import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/home/presentation/screens/home_screen.dart';
import 'package:remind_me_fe/features/authentication/presentation/login_screen.dart';
import 'package:remind_me_fe/features/list_todos/presentation/screens/add_screen.dart';
import 'package:remind_me_fe/features/list_todos/presentation/screens/list_screen.dart';
import 'package:remind_me_fe/features/list_todos/presentation/screens/update_screen.dart';
import 'package:remind_me_fe/features/theme/presentation/screens/choose_theme_screen.dart';
// import 'package:remind_me_fe/view/ToDo/add_screen.dart';
// import 'package:remind_me_fe/view/ToDo/list_screen.dart';
// import 'package:remind_me_fe/view/ToDo/update_screen.dart';
// import 'package:remind_me_fe/view/home/home_screen.dart';

class Routes {
  static const String homeRoute = '/home';

  static const String themeScreenRoute = '/theme';

  static const String todoListRoute = '/todo_list_comenzi';
  static const String todoUpdateRoute = '/todo_update_comenzi';
  static const String todoAddRoute = '/todo_add_comenzi';

  static const String loginRoute = '/login';
  static const String registerRoute = '/register';

  static Map<String, WidgetBuilder> generateRoutes() {
    return {
      homeRoute: (context) => const HomeScreen(),
      todoListRoute: (context) => TodoListScreen(context),
      todoUpdateRoute: (context) => TodoUpdateScreen(),
      todoAddRoute: (context) => TodoAddScreen(),
      loginRoute: (context) => LoginScreen(),
      themeScreenRoute: (context) => ThemeScreen(context),
    };
  }
}
