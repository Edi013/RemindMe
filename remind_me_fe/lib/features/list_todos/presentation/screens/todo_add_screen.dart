import 'package:flutter/material.dart';
import 'package:remind_me_fe/features/list_todos/presentation/controllers/add_controller.dart';

class TodoAddScreen extends StatelessWidget {
  final TodoAddController addController = TodoAddController();

  TodoAddScreen({super.key});

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      controller.text = addController.formatDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Object'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: addController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: addController.titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: addController.descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: addController.startDateController,
                decoration: const InputDecoration(labelText: 'Start Date *'),
                validator: (value) =>
                    addController.validateDateTimeFormField(value),
                onTap: () =>
                    _selectDate(context, addController.startDateController),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: addController.endDateController,
                decoration: const InputDecoration(labelText: 'End Date'),
                validator: (value) => addController.validateEndDateField(value),
                onTap: () =>
                    _selectDate(context, addController.endDateController),
                onChanged: (value) {
                  if (addController.endDateController.text.isEmpty) {
                    addController.endDateController.text =
                        addController.startDateController.text;
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: addController.difficultyController,
                decoration: const InputDecoration(labelText: 'Difficulty *'),
                validator: (value) =>
                    addController.validateDifficultyFormField(value),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => addController.addItem(context),
                child: const Text('Add Object'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
