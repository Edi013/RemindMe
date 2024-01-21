import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/models/logger/log.dart';
import 'package:remind_me_fe/repositories/logger_repository.dart';

class LoggerProvider extends ChangeNotifier {
  late LoggerRepository repository;

  // Private constructor
  LoggerProvider._singleton() {
    initialize();
  }

  // Static instance variable
  static final LoggerProvider _instance = LoggerProvider._singleton();

  // Static method to access the instance
  static LoggerProvider get instance => _instance;

  void initialize() {
    repository = LoggerRepository();
  }

  Future<void> logData(Log log) async {
    try {
      await repository.logData(log);
      notifyListeners();
    } catch (error) {
      // ignore: avoid_print
      print('Error logging data: $error');
    }
  }
}
