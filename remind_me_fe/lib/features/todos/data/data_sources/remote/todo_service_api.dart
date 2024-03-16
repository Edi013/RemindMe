import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:remind_me_fe/features/todos/data/models/create_todo_request.dart';
import 'package:remind_me_fe/features/todos/data/models/delete_todo_request.dart';
import 'package:remind_me_fe/features/todos/data/models/todo.dart';
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

  Future<List<TodoModel>> getAllByUserId(String userId) async {
    try {
      final response = await _dio.get('$apiUrl/GetAllByUserId/$userId');
      final List<dynamic> data = response.data;
      List<TodoModel> result =
          data.map((json) => TodoModel.fromJson(json)).toList();
      return result;
    } catch (error) {
      throw Exception('Failed to fetch todos: $error');
    }
  }

  Future<List<TodoModel>> getAllByUserIdActiveTodos(String userId) async {
    try {
      final response =
          await _dio.get('$apiUrl/GetAllActiveByUserIdItem/$userId');
      final List<dynamic> data = response.data;
      List<TodoModel> result =
          data.map((json) => TodoModel.fromJson(json)).toList();
      return result;
    } catch (error) {
      throw Exception('Failed to fetch todos: $error');
    }
  }

  Future<List<TodoModel>> getUndoneByUserIdTodos(String userId) async {
    try {
      final response = await _dio.get('$apiUrl/GetUndoneByUserIdItem/$userId');
      final List<dynamic> data = response.data;
      List<TodoModel> result =
          data.map((json) => TodoModel.fromJson(json)).toList();
      return result;
    } catch (error) {
      throw Exception('Failed to fetch todos: $error');
    }
  }

  Future<List<TodoModel>> getDoneByUserIdTodos(String userId) async {
    try {
      final response = await _dio.get('$apiUrl/GetDoneByUserIdItem/$userId');
      final List<dynamic> data = response.data;
      List<TodoModel> result =
          data.map((json) => TodoModel.fromJson(json)).toList();
      return result;
    } catch (error) {
      throw Exception('Failed to fetch todos: $error');
    }
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
