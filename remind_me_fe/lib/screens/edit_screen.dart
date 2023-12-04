import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/models/to_do.dart';
import 'package:remind_me_fe/providers/todo_provider.dart';

class EditScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int index = arguments['index'];
    ToDo toDoToUpdate = arguments['object'];

    TextEditingController titleController =
        TextEditingController(text: toDoToUpdate.title);
    TextEditingController descriptionController =
        TextEditingController(text: toDoToUpdate.description);
    TextEditingController startDateController =
        TextEditingController(text: toDoToUpdate.startDate.toString());

    TextEditingController endDateController =
        TextEditingController(text: toDoToUpdate.endDate.toString());

    TextEditingController difficultyController =
        TextEditingController(text: toDoToUpdate.difficulty.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Object'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the GlobalKey to the Form
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
                decoration:
                    const InputDecoration(labelText: 'End Date Controller'),
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

                    ToDo updatedToDo = ToDo(
                      title: title,
                      description: description,
                      creationDate: DateTime.now(),
                      startDate: startDate,
                      endDate: endDate,
                      difficulty: difficulty,
                      ownerId: toDoToUpdate.ownerId,
                      id: toDoToUpdate.id,
                      isFinished: toDoToUpdate.isFinished,
                    );

                    Provider.of<ToDoProvider>(context, listen: false)
                        .updateObject(index, updatedToDo);

                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Changes'),
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
