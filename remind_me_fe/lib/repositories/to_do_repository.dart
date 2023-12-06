import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:remind_me_fe/models/dto_requests/create_todo_request.dart';
import 'package:remind_me_fe/models/dto_requests/delete_todo_request.dart';
import 'package:remind_me_fe/models/dto_requests/update_todo_request.dart';

import 'package:remind_me_fe/models/todo_model.dart';
import 'package:remind_me_fe/shared/enviroment.dart';

class ToDoRepository {
  final String apiExtension = '/ToDo';
  final String apiUrl = "${Environment.BASE_URL}/ToDo";
  final dio = Dio();

  Future<List<ToDo>> getAll() async {
    final response = await http.get(
      Uri.parse('$apiUrl/GetAll'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*'
      },
    );

    final List<dynamic> data = json.decode(response.body);
    List<ToDo> result = data.map((json) => ToDo.fromJson(json)).toList();
    return result;
    //final response = await dio.get('$apiUrl/GetAll');
    //return response.data;
  }

  Future<ToDo> addTodo(ToDo todo) async {
    CreateToDoRequest newToDo = CreateToDoRequest(
      title: todo.title,
      description: todo.description,
      creationDate: todo.creationDate,
      startDate: todo.startDate,
      isFinished: todo.isFinished,
      difficulty: todo.difficulty,
      ownerId: todo.ownerId,
    );

    final response = await http.post(
      Uri.parse('$apiUrl/Create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newToDo.toJson()),
    );

    // if (response.statusCode == 201 || response.statusCode == 200) {
    return ToDo.fromJson(json.decode(response.body));
    // } else {
    //   throw Exception('Failed to add todo');
    // }
  }

  Future<void> updateTodo(ToDo todo) async {
    UpdateToDoRequest updatedToDo = UpdateToDoRequest(
      id: todo.id!,
      title: todo.title,
      description: todo.description,
      difficulty: todo.difficulty,
      isFinished: todo.isFinished,
      startDate: todo.startDate,
      endDate: todo.endDate,
      ownerId: todo.ownerId,
    );

    final response = await http.put(
      Uri.parse('$apiUrl/Update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedToDo.toJson()),
    );

    // if (response.statusCode != 200) {
    //   throw Exception('Failed to update todo');
    // }
  }

  Future<void> deleteTodo(int todoId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/Delete'),
      body: DeleteToDoRequest(id: todoId),
    );

    // if (response.statusCode != 200) {
    //   throw Exception('Failed to delete todo');
    // }
  }
}
