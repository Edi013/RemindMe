import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:remind_me_fe/models/todo_dtos/create_todo_request.dart';
import 'package:remind_me_fe/models/todo_dtos/delete_todo_request.dart';
import 'package:remind_me_fe/models/todo_dtos/update_todo_request.dart';

import 'package:remind_me_fe/models/todo_model.dart';
import 'package:remind_me_fe/shared/enviroment.dart';

class ToDoRepository {
  final String apiExtension = '/ToDo';
  late String apiUrl ;

  ToDoRepository(){
    apiUrl = "${Environment.BASE_URL}${apiExtension}";
  }
  
  Future<List<ToDo>> getAll() async {
    // var result = await http.get(
    //   Uri.parse('$apiUrl/GetAll'),
    //   headers: {
    //     "Access-Control-Allow-Origin": "*",
    //     'Content-Type': 'application/json; charset=UTF-8',
    //     'Accept': '*/*'
    //   },
    // ).then(
    //   (response) {
    //     final List<dynamic> data = json.decode(response.body);
    //     List<ToDo> result = data.map((json) => ToDo.fromJson(json)).toList();
    //     return result;
    //   },
    // );
    // return result;
    List<ToDo> toDoList = [
      ToDo(
        id: 1,
        title: "Complete Flutter Project",
        description: "Finish the tasks in the Flutter project",
        creationDate: DateTime.now(),
        startDate: DateTime(2024, 1, 21),
        endDate: DateTime(2024, 1, 25),
        isFinished: false,
        difficulty: 3,
        ownerId: 123,
      ),
      ToDo(
        id: 2,
        title: "Study Dart Programming",
        description: "Learn Dart programming language",
        creationDate: DateTime.now(),
        startDate: DateTime(2024, 1, 22),
        endDate: DateTime(2024, 1, 30),
        isFinished: false,
        difficulty: 2,
        ownerId: 456,
      ),
      ToDo(
        id: 3,
        title: "Exercise",
        description: "Go for a jog or hit the gym",
        creationDate: DateTime.now(),
        startDate: DateTime(2024, 1, 23),
        endDate: DateTime(2024, 1, 31),
        isFinished: false,
        difficulty: 1,
        ownerId: 789,
      ),
    ];
    return toDoList;
  }

  Future<ToDo> addTodo(ToDo todo) async {
    CreateToDoRequest newToDo = CreateToDoRequest(
      title: todo.title,
      description: todo.description,
      creationDate: todo.creationDate,
      startDate: todo.startDate,
      endDate: todo.endDate,
      isFinished: todo.isFinished,
      difficulty: todo.difficulty,
      ownerId: todo.ownerId,
    );

    return await http
        .post(
          Uri.parse('$apiUrl/Create'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(newToDo.toJson()),
        )
        .then(
          (value) => ToDo.fromJson(json.decode(value.body)),
        );
  }

  Future<ToDo> updateTodo(ToDo todo) async {
    UpdateToDoRequest updatedToDo = UpdateToDoRequest(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      difficulty: todo.difficulty,
      isFinished: todo.isFinished,
      creationDate: todo.creationDate,
      startDate: todo.startDate,
      endDate: todo.endDate,
      ownerId: todo.ownerId,
    );

    return await http
        .put(
          Uri.parse('$apiUrl/Update'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(updatedToDo.toJson()),
        )
        .then(
          (value) => ToDo.fromJson(json.decode(value.body)),
        );
  }

  Future<void> deleteTodo(int todoId) async {
    DeleteToDoRequest deleteRequest = DeleteToDoRequest(id: todoId);

    await http
        .delete(
      Uri.parse('$apiUrl/Delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(deleteRequest.toJson()),
    )
        .then((value) {
      return;
    });
  }
}
