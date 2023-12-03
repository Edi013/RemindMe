import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/models/object_model.dart';
import 'package:remind_me_fe/providers/object_provider.dart';

class EditScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int index = arguments['index'];
    ObjectModel object = arguments['object'];

    TextEditingController nameController =
        TextEditingController(text: object.name);
    TextEditingController descriptionController =
        TextEditingController(text: object.description);

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
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => validateFormField(value),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => validateFormField(value),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ObjectModel updatedObject = ObjectModel(
                      name: nameController.text,
                      description: descriptionController.text,
                    );

                    Provider.of<ObjectProvider>(context, listen: false)
                        .updateObject(index, updatedObject);

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
    } else if (value.length < 2) {
      return 'Field must be at least 2 characters';
    }
    return null;
  }
}
