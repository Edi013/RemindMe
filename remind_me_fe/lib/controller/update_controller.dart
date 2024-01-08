import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/models/todo_model.dart';
import 'package:remind_me_fe/providers/todo_provider.dart';

class EditController {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _difficultyController;

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get startDateController => _startDateController;
  TextEditingController get endDateController => _endDateController;
  TextEditingController get difficultyController => _difficultyController;

  void initControllers(ToDo toDoToUpdate) {
    _titleController = TextEditingController(text: toDoToUpdate.title);
    _descriptionController =
        TextEditingController(text: toDoToUpdate.description);
    _startDateController =
        TextEditingController(text: toDoToUpdate.startDate.toString());
    _endDateController =
        TextEditingController(text: toDoToUpdate.endDate.toString());
    _difficultyController =
        TextEditingController(text: toDoToUpdate.difficulty.toString());
  }

  String? validateFormField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    } else if (value.length < 2 && int.tryParse(value) == null) {
      return 'Field must be at least 2 characters';
    }
    return null;
  }

  void saveChanges(
    String title,
    String description,
    String startDate,
    String endDate,
    String difficulty,
    int index,
    ToDo toDoToUpdate,
    BuildContext context,
  ) {
    if (_formKey.currentState!.validate()) {
      DateTime parsedStartDate = DateTime.parse(startDate);
      DateTime? parsedEndDate = endDate != "" ? DateTime.parse(endDate) : null;
      int parsedDifficulty = int.parse(difficulty);

      ToDo updatedToDo = ToDo(
        title: title,
        description: description,
        creationDate: DateTime.now(),
        startDate: parsedStartDate,
        endDate: parsedEndDate,
        difficulty: parsedDifficulty,
        ownerId: toDoToUpdate.ownerId,
        id: toDoToUpdate.id,
        isFinished: toDoToUpdate.isFinished,
      );

      Provider.of<ToDoProvider>(context, listen: false)
          .update(index, updatedToDo);

      Navigator.pop(context);
    }
  }
}
