import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/bar/presentation/layout_by_orientation.dart';
import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/todos/presentation/controllers/update_controller.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

@RoutePage()
class TodoUpdateScreen extends StatelessWidget {
  late int index;
  late TodoEntity todo;

  TodoUpdateScreen({
    super.key,
    @PathParam('index') required this.index,
    @PathParam('todoId') required int todoId,
  }) {
    todo =
        sl<TodoProvider>().todos.where((element) => element.id == todoId).first;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutByOrientation(TodoUpdateScreenContent(todo, index));
  }
}

class TodoUpdateScreenContent extends StatelessWidget {
  final TodoUpdateController controller = TodoUpdateController();
  late int index;
  late TodoEntity todoToUpdate;

  TodoUpdateScreenContent(TodoEntity _todoToUpdate, int _index, {super.key}) {
    todoToUpdate = _todoToUpdate;
    index = _index;
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController currentController) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        currentController.text = controller.formatDate(selectedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.initControllers(todoToUpdate);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: controller.titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: controller.descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: controller.startDateController,
                decoration: const InputDecoration(labelText: 'Start Date *'),
                validator: (value) => controller.validateFormField(value),
                onTap: () =>
                    _selectDate(context, controller.startDateController),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: controller.endDateController,
                decoration:
                    const InputDecoration(labelText: 'End Date Controller'),
                validator: (value) => controller.validateEndDateField(value),
                onTap: () => _selectDate(context, controller.endDateController),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: controller.difficultyController,
                decoration: const InputDecoration(labelText: 'Difficulty *'),
                validator: (value) => controller.validateFormField(value),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  controller.updateItem(
                    index,
                    todoToUpdate,
                    context,
                  );
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
