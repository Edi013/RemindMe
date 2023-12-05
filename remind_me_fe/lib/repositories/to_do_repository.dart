import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:remind_me_fe/models/todo_model.dart';
import 'package:remind_me_fe/shared/enviroment.dart';

class ToDoRepository {
  final String apiUrl = Environment.BASE_URL;

  Future<List<ToDo>> getAll() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ToDo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to getAll todos');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
