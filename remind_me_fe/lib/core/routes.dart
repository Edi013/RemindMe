import 'package:flutter/material.dart';
import 'package:remind_me_fe/features/home/presentation/screens/home_screen.dart';
import 'package:remind_me_fe/features/authentication/presentation/screens/expired_session_screen.dart';
import 'package:remind_me_fe/features/authentication/presentation/screens/login_screen.dart';
import 'package:remind_me_fe/features/authentication/presentation/screens/register_screen.dart';
import 'package:remind_me_fe/features/list_todos/presentation/screens/todo_add_screen.dart';
import 'package:remind_me_fe/features/list_todos/presentation/screens/todo_list_screen.dart';
import 'package:remind_me_fe/features/list_todos/presentation/screens/todo_update_screen.dart';
import 'package:remind_me_fe/features/theme/presentation/screens/choose_theme_screen.dart';

class Routes {
  static const String homeRoute = '/home';

  static const String themeScreenRoute = '/theme';

  static const String todoListRoute = '/todo_list';
  static const String todoUpdateRoute = '/todo_update';
  static const String todoAddRoute = '/todo_add';

  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String sessionExpiredRoute = '/session_expired';

  static Map<String, WidgetBuilder> generateRoutes() {
    return {
      homeRoute: (context) => const HomeScreen(),
      themeScreenRoute: (context) => ThemeScreen(context),
      todoListRoute: (context) => const TodoListScreen(),
      todoUpdateRoute: (context) => TodoUpdateScreen(),
      todoAddRoute: (context) => const TodoAddScreen(),
      loginRoute: (context) => LoginScreen(),
      registerRoute: (context) => const RegisterScreen(),
      sessionExpiredRoute: (context) => const SessionExpiredScreen(),
    };
  }
}
