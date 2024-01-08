import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/providers/todo_provider.dart';

class ToDoListController {
  void deleteById(BuildContext context, int id) {
    Provider.of<ToDoProvider>(context, listen: false).delete(id);
  }
}
