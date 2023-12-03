import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/models/object_model.dart';
import 'package:remind_me_fe/providers/object_provider.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Object List'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Object List',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Consumer<ObjectProvider>(
                  builder: (context, objectProvider, child) {
                    return ListView.builder(
                      itemCount: objectProvider.objects.length,
                      itemBuilder: (context, index) {
                        ObjectModel object = objectProvider.objects[index];
                        return ListTile(
                          title: Text(object.name),
                          subtitle: Text(object.description),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/form',
                              arguments: {'index': index, 'object': object},
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add');
                  },
                  child: Text('Add Object'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
