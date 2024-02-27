import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/features/list_todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/list_todos/presentation/providers/todo_provider.dart';

class TodoUpdateController {
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

  void initControllers(TodoEntity toDoToUpdate) {
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

  String? validateEndDateField(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (value.length < 10) {
      return 'Field must have this format 2000-01-01';
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
    TodoEntity toDoToUpdate,
    BuildContext context,
  ) {
    if (_formKey.currentState!.validate()) {
      DateTime parsedStartDate = DateTime.parse(startDate);
      DateTime? parsedEndDate = endDate != "" ? DateTime.parse(endDate) : null;
      int parsedDifficulty = int.parse(difficulty);

      TodoEntity updatedTodoEntity = TodoEntity(
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

      Provider.of<TodoProvider>(context, listen: false)
          .update(index, updatedTodoEntity);

      Navigator.pop(context);
    }
  }
}
