import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/models/object_model.dart';

class ObjectProvider extends ChangeNotifier {
  List<ObjectModel> _objects = [
    ObjectModel(name: 'Object 1', description: 'Description 1'),
    ObjectModel(name: 'Object 2', description: 'Description 2'),
  ];

  List<ObjectModel> get objects => _objects;

  void addObject(ObjectModel object) {
    _objects.add(object);
    notifyListeners();
  }

  void updateObject(int index, ObjectModel updatedObject) {
    _objects[index] = updatedObject;
    notifyListeners();
  }
}
