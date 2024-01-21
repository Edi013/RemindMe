import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/color_scheme.dart';
import 'package:remind_me_fe/providers/logger_provider.dart';
import 'package:remind_me_fe/providers/todo_provider.dart';
import 'package:remind_me_fe/routes.dart';

void main() {
  try {
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
