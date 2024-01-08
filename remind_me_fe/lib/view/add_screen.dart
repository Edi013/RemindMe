import 'package:flutter/material.dart';
import 'package:remind_me_fe/controller/add_controller.dart';

class AddScreen extends StatelessWidget {
  final AddController addController = AddController();

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
                validator: (value) => addController.validateFormField(value),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: addController.endDateController,
                decoration: const InputDecoration(labelText: 'End Date'),
                validator: (value) => addController.validateFormField(value),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: addController.difficultyController,
                decoration: const InputDecoration(labelText: 'Difficulty *'),
                validator: (value) => addController.validateFormField(value),
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
