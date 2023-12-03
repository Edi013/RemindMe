import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/providers/object_provider.dart';
import 'package:remind_me_fe/screens/add_screen.dart';
import 'package:remind_me_fe/screens/form_screen.dart';
import 'package:remind_me_fe/screens/list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ObjectProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Object App',
      initialRoute: '/list',
      routes: {
        '/list': (context) => ListScreen(),
        '/form': (context) => FormScreen(),
        '/add': (context) => AddScreen(),
      },
    );
  }
}
