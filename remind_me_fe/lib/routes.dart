import 'package:flutter/material.dart';
import 'package:remind_me_fe/view/ToDo/add_screen.dart';
import 'package:remind_me_fe/view/ToDo/list_screen.dart';
import 'package:remind_me_fe/view/ToDo/update_screen.dart';
import 'package:remind_me_fe/view/home/home_screen.dart';

class Routes {
  static const String homeRoute = '/home';

  static const String todoListRoute = '/todo_list_comenzi';
  static const String todoUpdateRoute = '/todo_update_comenzi';
  static const String todoAddRoute = '/todo_add_comenzi';

  static Map<String, WidgetBuilder> generateRoutes() {
    return {
      homeRoute: (context) => HomeScreen(),
      todoListRoute: (context) => ToDoListScreen(),
      todoUpdateRoute: (context) => ToDoUpdateScreen(),
      todoAddRoute: (context) => ToDoAddScreen(),
    };
  }
}
