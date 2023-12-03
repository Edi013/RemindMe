import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/models/object_model.dart';
import 'package:remind_me_fe/providers/object_provider.dart';

class AddScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Object'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String description = descriptionController.text;

                if (name.isNotEmpty && description.isNotEmpty) {
                  ObjectModel newObject =
                      ObjectModel(name: name, description: description);

                  Provider.of<ObjectProvider>(context, listen: false)
                      .addObject(newObject);

                  Navigator.pop(context); // Go back to the previous screen
                } else {
                  // Show an error message or handle the case where fields are empty
                }
              },
              child: Text('Add Object'),
            ),
          ],
        ),
      ),
    );
  }
}
