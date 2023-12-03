import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/providers/object_provider.dart';
import 'package:remind_me_fe/screens/add_screen.dart';
import 'package:remind_me_fe/screens/edit_screen.dart';
import 'package:remind_me_fe/screens/list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ObjectProvider(),
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
