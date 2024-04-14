import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

class TodoAddController {
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

  Future<void> addItem(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String description = _descriptionController.text;
      DateTime startDate = DateTime.parse(
        _startDateController.text,
      );
      DateTime? endDate = _endDateController.text.isNotEmpty
          ? DateTime.parse(
              _endDateController.text,
            )
          : startDate.add(const Duration(days: 1));
      int difficulty = int.parse(_difficultyController.text);
      CurrentUser user = sl<CurrentUser>();
      TodoEntity newObject = TodoEntity(
        id: 0,
        title: title,
        description: description,
        startDate: startDate,
        endDate: endDate,
        difficulty: difficulty,
        ownerId: user.id!,
      );

      Provider.of<TodoProvider>(context, listen: false).add(newObject);

      Navigator.pop(context);
      //AutoRouter.of(context).navigate(const ActiveTodosRoute());
    }
  }

  void setDescriptionMarkdown(String markdownContent) {
    _descriptionController.text = markdownContent;
  }

  void clearDescription() {
    _descriptionController.clear();
  }

  String? validateDateTimeFormField(value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    } else if (value.length < 10) {
      return 'Field must have this format 2000-01-01';
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
    } else if (value.length < 10) {
      return 'Date format is not valid, use the date picker';
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

  String formatDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}"
        "T${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00.000";
  }
}
