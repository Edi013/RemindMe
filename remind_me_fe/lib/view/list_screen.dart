import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/controller/list_controller.dart';
import 'package:remind_me_fe/models/todo_model.dart';
import 'package:remind_me_fe/providers/todo_provider.dart';

class ListScreen extends StatelessWidget {
  final ListController controller = ListController();

  ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Object List'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'To do',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Consumer<ToDoProvider>(
                  builder: (context, toDoProvider, child) {
                    return ListView.builder(
                      itemCount: toDoProvider.todos.length,
                      itemBuilder: (context, index) {
                        ToDo toDo = toDoProvider.todos[index];
                        return ListTile(
                          title: Text(toDo.title),
                          subtitle: Column(
                            children: [
                              Text("Description: ${toDo.description}"),
                              Text(
                                  "Creation Date: ${toDo.creationDate.toString()}"),
                              Text("Start Date: ${toDo.startDate.toString()}"),
                              Text("End Date: ${toDo.endDate.toString()}"),
                              Text(
                                  "Is finished: ${toDo.isFinished.toString()}"),
                              Text("Difficulty: ${toDo.difficulty.toString()}"),
                              IconButton(
                                onPressed: () =>
                                    controller.deleteById(context, toDo.id!),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/update',
                              arguments: {'index': index, 'object': toDo},
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
                  child: const Text('Add Object'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
