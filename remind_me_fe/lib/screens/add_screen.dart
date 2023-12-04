import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/models/to_do.dart';
import 'package:remind_me_fe/providers/todo_provider.dart';

class AddScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController difficultyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Object'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: startDateController,
                decoration: const InputDecoration(labelText: 'Start Date *'),
                validator: (value) => validateFormField(value),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: endDateController,
                decoration: const InputDecoration(labelText: 'End Date'),
                validator: (value) => validateFormField(value),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: difficultyController,
                decoration: const InputDecoration(labelText: 'Difficulty *'),
                validator: (value) => validateFormField(value),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String title = titleController.text;
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

                    ToDo newObject = ToDo(
                      title: title,
                      description: description,
                      creationDate: DateTime.now(),
                      startDate: startDate,
                      endDate: endDate,
                      difficulty: difficulty,
                      ownerId: -1,
                    );

                    Provider.of<ToDoProvider>(context, listen: false)
                        .addObject(newObject);

                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Object'),
              ),
            ],
          ),
        ),
      ),
    );
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
