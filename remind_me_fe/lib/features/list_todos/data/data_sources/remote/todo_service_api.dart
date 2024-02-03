import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:remind_me_fe/features/list_todos/data/models/create_todo_request.dart';
import 'package:remind_me_fe/features/list_todos/data/models/delete_todo_request.dart';
import 'package:remind_me_fe/features/list_todos/data/models/todo.dart';
import 'package:remind_me_fe/core/constants.dart';

class TodoServiceApi {
  final String apiExtension = '/ToDo';
  late String apiUrl;

  TodoServiceApi() {
    apiUrl = "$BASE_URL_TODOS$apiExtension";
  }

  Future<List<TodoModel>> getAll() async {
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
        List<TodoModel> result =
            data.map((json) => TodoModel.fromJson(json)).toList();
        return result;
      },
    );
    return result.isEmpty ? seedData() : result;
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

    return await http
        .post(
          Uri.parse('$apiUrl/Create'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(newToDo.toJson()),
        )
        .then(
          (value) => TodoModel.fromJson(json.decode(value.body)),
        );
  }

  Future<TodoModel> updateTodo(TodoModel updatedToDo) async {
    return await http
        .put(
          Uri.parse('$apiUrl/Update'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(updatedToDo.toJson()),
        )
        .then(
          (value) => TodoModel.fromJson(json.decode(value.body)),
        );
  }

  Future<void> deleteTodo(int todoId) async {
    DeleteToDoRequest deleteRequest = DeleteToDoRequest(id: todoId);

    await http.delete(
      Uri.parse('$apiUrl/Delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(deleteRequest.toJson()),
    );
  }
}
