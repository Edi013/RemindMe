import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/snackBar/snack_bar.dart';
import 'package:remind_me_fe/features/list_todos/data/models/create_todo_request.dart';
import 'package:remind_me_fe/features/list_todos/data/models/delete_todo_request.dart';
import 'package:remind_me_fe/features/list_todos/data/models/todo.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/injection_container.dart';

class TodoServiceApi {
  final String apiExtension = '/Item';
  late String apiUrl;
  late Dio _dio;

  TodoServiceApi() {
    apiUrl = "$BASE_URL_TODOS$apiExtension";
    _dio = sl<Dio>();
  }

  Future<List<TodoModel>> getAll() async {
    try {
      final response = await _dio.get('$apiUrl/GetAll');
      final List<dynamic> data = response.data;
      List<TodoModel> result =
          data.map((json) => TodoModel.fromJson(json)).toList();
      return result.isEmpty ? seedData() : result;
    } catch (error) {
      throw Exception('Failed to fetch todos: $error');
    }
  }

  List<TodoModel> seedData() {
    List<TodoModel> toDoList = [
      TodoModel(
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
      TodoModel(
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
      TodoModel(
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

  Future<TodoModel> addTodo(TodoModel todo) async {
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

    try {
      final response = await _dio.post(
        '$apiUrl/Create',
        data: jsonEncode(newToDo.toJson()),
      );

      if (response.statusCode == 400) {
        throw Exception('Failed to add todo: Bad Request');
      }

      return TodoModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to add todo: $error');
    }
  }

  Future<TodoModel> updateTodo(TodoModel updatedToDo) async {
    try {
      final response = await _dio.put(
        '$apiUrl/Update',
        data: jsonEncode(updatedToDo.toJson()),
      );

      if (response.statusCode == 400) {
        throw Exception('Failed to add todo: Bad Request');
      }

      return TodoModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to update todo: $error');
    }
  }

  Future<void> deleteTodo(int todoId) async {
    DeleteToDoRequest deleteRequest = DeleteToDoRequest(id: todoId);

    try {
      await _dio.delete(
        '$apiUrl/Delete',
        data: jsonEncode(deleteRequest.toJson()),
      );
    } catch (error) {
      throw Exception('Failed to delete todo: $error');
    }
  }
}
