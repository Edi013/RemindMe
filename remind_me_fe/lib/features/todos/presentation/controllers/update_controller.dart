import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';

class TodoUpdateController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController difficultyController;

  void initControllers(TodoEntity toDoToUpdate) {
    titleController = TextEditingController(text: toDoToUpdate.title);
    descriptionController =
        TextEditingController(text: toDoToUpdate.description);
    startDateController =
        TextEditingController(text: toDoToUpdate.startDate.toString());
    endDateController =
        TextEditingController(text: toDoToUpdate.endDate.toString());
    difficultyController =
        TextEditingController(text: toDoToUpdate.difficulty.toString());
  }

  String? validateStartDateFormField(value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    } else if (DateTime.tryParse(value) == null) {
      return 'Date format is not valid';
    }

    return null;
  }

  String? validateDifficultyFormField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }

    int? intValue = int.tryParse(value);

    if (intValue == null) {
      return 'Invalid input. Please enter a valid number';
    }

    if (intValue < 1) {
      return 'Difficulty must be greater or equal to 1';
    } else if (intValue > 10) {
      return 'Difficulty must be less or equal to 10';
    }

    return null;
  }

  String? validateEndDateField(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (DateTime.tryParse(value) == null) {
      return 'Date format is not valid';
    } else if (startDateController.text.isEmpty) {
      return 'Start date has to be provided first';
    } else if (DateTime.tryParse(startDateController.text) == null) {
      return 'A valid start date has to be provided first';
    } else if (DateTime.parse(value)
        .isBefore(DateTime.parse(startDateController.text))) {
      return 'End date has to be after the start date';
    }
    return null;
  }

  void updateItem(int index, TodoEntity toDoToUpdate, BuildContext context,
      String listName) {
    if (formKey.currentState!.validate()) {
      DateTime startDate = DateTime.parse(startDateController.text);
      DateTime? endDate = endDateController.text != ""
          ? DateTime.parse(endDateController.text)
          : startDate.add(const Duration(days: 1));
      int difficulty = int.parse(difficultyController.text);

      TodoEntity updatedTodoEntity = TodoEntity(
        title: titleController.text,
        description: descriptionController.text,
        startDate: startDate,
        endDate: endDate,
        difficulty: difficulty,
        ownerId: toDoToUpdate.ownerId,
        id: toDoToUpdate.id,
        isFinished: toDoToUpdate.isFinished,
      );

      Provider.of<TodoProvider>(context, listen: false)
          .update(index, listName, updatedTodoEntity);

      Navigator.pop(context);
    }
  }

  String formatDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}"
        " ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
