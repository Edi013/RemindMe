import 'package:flutter/material.dart';
import 'package:remind_me_fe/routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.todoListRoute);
          },
          child: const Text('Go to Todo List'),
        ),
      ),
    );
  }
}
