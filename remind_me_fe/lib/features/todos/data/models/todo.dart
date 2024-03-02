import 'package:intl/intl.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/todos/domain/entities/todo.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required id,
    String title = "",
    String description = "",
    required DateTime creationDate,
    required DateTime startDate,
    required DateTime endDate,
    bool isFinished = false,
    required int difficulty,
    required int ownerId,
  }) : super(
          id: id,
          title: title,
          description: description,
          creationDate: creationDate,
          startDate: startDate,
          endDate: endDate,
          isFinished: isFinished,
          difficulty: difficulty,
          ownerId: ownerId,
        ) {
    creationDate = DateTime.now();
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      creationDate: DateFormat(DATE_TIME_FORMAT).parse(json['creationDate']),
      startDate: DateFormat(DATE_TIME_FORMAT).parse(json['startDate']),
      endDate: DateFormat(DATE_TIME_FORMAT).parse(json['endDate']),
      difficulty: json['difficulty'],
      isFinished: json['isFinished'] as bool,
      ownerId: json['ownerId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creationDate': creationDate.toIso8601String(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isFinished': isFinished,
      'difficulty': difficulty,
      'ownerId': ownerId,
    };
  }

  TodoEntity toTodoEntity() {
    return TodoEntity(
      id: id,
      title: title,
      description: description,
      creationDate: creationDate,
      startDate: startDate,
      endDate: endDate,
      isFinished: isFinished,
      difficulty: difficulty,
      ownerId: ownerId,
    );
  }

  TodoModel.fromTodoEntity(TodoEntity todoEntity)
      : super(
          id: todoEntity.id,
          title: todoEntity.title,
          description: todoEntity.description,
          creationDate: todoEntity.creationDate,
          startDate: todoEntity.startDate,
          endDate: todoEntity.endDate,
          isFinished: todoEntity.isFinished,
          difficulty: todoEntity.difficulty,
          ownerId: todoEntity.ownerId,
        );
}
