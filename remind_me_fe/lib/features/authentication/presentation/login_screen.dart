import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/config/routes.dart';
import 'package:remind_me_fe/features/list_todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/list_todos/presentation/providers/todo_provider.dart';

class LoginScreen extends StatelessWidget {
  //final TodoListController controller = TodoListController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
