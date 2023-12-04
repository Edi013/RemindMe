import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/models/to_do.dart';

class ToDoProvider extends ChangeNotifier {
  final List<ToDo> _objects = [
    ToDo(
      title: 'Object 1',
      description: 'Description 1',
      creationDate: DateTime.now(),
      startDate: DateTime.now(),
      difficulty: 1,
      isFinished: false,
      ownerId: -1,
    ),
    ToDo(
      title: 'To Do 2',
      description: 'Description To Do 2',
      creationDate: DateTime.now(),
      startDate: DateTime.now(),
      difficulty: 2,
      isFinished: false,
      ownerId: -1,
    ),
  ];

  List<ToDo> get objects => _objects;

  void addObject(ToDo object) {
    _objects.add(object);
    notifyListeners();
  }

  void updateObject(int index, ToDo updatedObject) {
    _objects[index] = updatedObject;
    notifyListeners();
  }
}
