import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/color_scheme.dart';
import 'package:remind_me_fe/providers/logger_provider.dart';
import 'package:remind_me_fe/providers/todo_provider.dart';
import 'package:remind_me_fe/routes.dart';
import 'package:dio/dio.dart';


void main() {
 try {
    // Initialize Dio with interceptors
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Modify request headers or perform other actions before sending the request
        handler.next(options);
      },
      onResponse: (response, handler) {
        // Modify response or perform other actions after receiving the response
        handler.next(response);
      },
      onError: (DioError e, handler) {
        // Handle errors, including 401 Unauthorized
        if (e.response?.statusCode == 401) {
          // Redirect to login screen or perform other actions
          navigatorKey.currentState?.pushReplacementNamed('/login');
        }

        handler.next(e);
      },
    ));

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ToDoProvider>(
              create: (_) => ToDoProvider.instance),
          ChangeNotifierProvider<LoggerProvider>(
              create: (_) => LoggerProvider.instance),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    // ignore: avoid_print
    print("Error: $e + Stacktrace: $stackTrace");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RemindMe',
      initialRoute: Routes.homeRoute,
      routes: Routes.generateRoutes(),
      theme: ThemeData(
        colorScheme: AppColors.getAppColorScheme(),
      ),
    );
  }
}
