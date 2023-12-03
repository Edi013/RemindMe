import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/models/object_model.dart';
import 'package:remind_me_fe/providers/object_provider.dart';

class FormScreen extends StatelessWidget {
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
        title: Text('Edit Object'),
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
                ObjectModel updatedObject = ObjectModel(
                  name: nameController.text,
                  description: descriptionController.text,
                );

                Provider.of<ObjectProvider>(context, listen: false)
                    .updateObject(index, updatedObject);

                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
