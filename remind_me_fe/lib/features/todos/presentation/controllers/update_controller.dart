import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      return 'Date format is not valid, use the date picker';
    } else if (DateTime.tryParse(value) == null) {
      return 'Date format is not valid';
    } else if (startDateController.text.isEmpty) {
      return 'Start date must be filled in before you enter an end date';
    } else if (DateTime.tryParse(startDateController.text) == null) {
      return 'Start date must be filled in before you enter an end date';
    } else if (DateTime.tryParse(value)!
        .isBefore(DateTime.tryParse(startDateController.text)!)) {
      return 'End date has to be after the start date';
    }
    //convert startDateController.text to datetime and verifify if isAfter(value ca DateTime)
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
