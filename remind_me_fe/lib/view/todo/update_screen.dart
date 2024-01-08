import 'package:flutter/material.dart';
import 'package:remind_me_fe/controller/todo/update_controller.dart';
import 'package:remind_me_fe/models/todo_model.dart';

class ToDoUpdateScreen extends StatelessWidget {
  final ToDoUpdateController controller = ToDoUpdateController();

  ToDoUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int index = arguments['index'];
    ToDo toDoToUpdate = arguments['object'];

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
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: controller.endDateController,
                decoration:
                    const InputDecoration(labelText: 'End Date Controller'),
                validator: (value) => controller.validateFormField(value),
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
                  controller.saveChanges(
                    controller.titleController.text,
                    controller.descriptionController.text,
                    controller.startDateController.text,
                    controller.endDateController.text,
                    controller.difficultyController.text,
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
