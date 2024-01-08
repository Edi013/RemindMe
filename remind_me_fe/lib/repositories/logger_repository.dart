import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:remind_me_fe/models/logger/log.dart';
import 'package:remind_me_fe/models/logger/response_logger.dart';
import 'package:remind_me_fe/shared/enviroment.dart';

class LoggerRepository {
  final String apiExtension = '/Logger';
  final String apiUrl = "${Environment.BASE_URL}/Logger";

  Future<void> logData(Log log) async {
    ResponeLogger? result;
    await http
        .post(
          Uri.parse('$apiUrl/Log'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
          },
          body: log.toJson(),
        )
        .then(
          (value) => result = ResponeLogger.fromJson(json.decode(value.body)),
        );

    if (result == null ||
        result!.httpStatusCode !=
            ResponeLogger.createdSuccessfullyHttpCodeStatus) {
      throw Exception('Failed to log data.');
    }
  }
}
