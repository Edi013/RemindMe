import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/bar/presentation/screen_by_orientation.dart';
import 'package:remind_me_fe/features/list_todos/domain/entities/todo.dart';
import 'package:remind_me_fe/features/list_todos/presentation/controllers/update_controller.dart';

class TodoUpdateScreen extends StatelessWidget {
  const TodoUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutByOrientation(TodoUpdateScreenContent());
  }
}

class TodoUpdateScreenContent extends StatelessWidget {
  final TodoUpdateController controller = TodoUpdateController();

  TodoUpdateScreenContent({super.key});

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
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int index = arguments['index'];
    TodoEntity toDoToUpdate = arguments['object'];

    controller.initControllers(toDoToUpdate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Object'),
      ),
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
                    toDoToUpdate,
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
