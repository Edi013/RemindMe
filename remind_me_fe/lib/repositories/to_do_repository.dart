import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:remind_me_fe/models/todo_dtos/create_todo_request.dart';
import 'package:remind_me_fe/models/todo_dtos/delete_todo_request.dart';
import 'package:remind_me_fe/models/todo_dtos/update_todo_request.dart';

import 'package:remind_me_fe/models/todo_model.dart';
import 'package:remind_me_fe/shared/enviroment.dart';

class ToDoRepository {
  final String apiExtension = '/ToDo';
  final String apiUrl = "${Environment.BASE_URL}/ToDo";

  Future<List<ToDo>> getAll() async {
    var result = await http.get(
      Uri.parse('$apiUrl/GetAll'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*'
      },
    ).then(
      (response) {
        final List<dynamic> data = json.decode(response.body);
        List<ToDo> result = data.map((json) => ToDo.fromJson(json)).toList();
        return result;
      },
    );
    return result;
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
      id: todo.id!,
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
