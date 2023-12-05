import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/providers/todo_provider.dart';
import 'package:remind_me_fe/view/add_screen.dart';
import 'package:remind_me_fe/view/list_screen.dart';
import 'package:remind_me_fe/view/edit_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ToDoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Object App',
      initialRoute: '/list',
      routes: {
        '/list': (context) => const ListScreen(),
        '/edit': (context) => EditScreen(),
        '/add': (context) => AddScreen(),
      },
    );
  }
}
