import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/models/todo_model.dart';
import 'package:remind_me_fe/providers/todo_provider.dart';

class AddController {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _difficultyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get startDateController => _startDateController;
  TextEditingController get endDateController => _endDateController;
  TextEditingController get difficultyController => _difficultyController;
  GlobalKey<FormState> get formKey => _formKey;

  void addItem(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String description = descriptionController.text;
      DateTime startDate = DateTime.parse(
        startDateController.text,
      );
      DateTime? endDate = endDateController.text != ""
          ? DateTime.parse(
              endDateController.text,
            )
          : null;
      int difficulty = int.parse(difficultyController.text);
      print(DateTime.now());
      ToDo newObject = ToDo(
        title: title,
        description: description,
        creationDate: DateTime.now(),
        startDate: startDate,
        endDate: endDate,
        difficulty: difficulty,
        ownerId: -1,
      );

      Provider.of<ToDoProvider>(context, listen: false).add(newObject);

      Navigator.pop(context);
    }
  }

  String? validateFormField(value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    } else if (value.length < 2 && int.tryParse(value) == null) {
      return 'Field must be at least 2 characters';
    }
    return null;
  }
}
