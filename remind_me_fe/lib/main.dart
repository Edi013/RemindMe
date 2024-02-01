import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/config/color_scheme.dart';
import 'package:remind_me_fe/config/routes.dart';
import 'package:remind_me_fe/features/list_todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

Future<void> main() async {
  await initializeDependencies();
  try {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<TodoProvider>(
              create: (_) => sl<TodoProvider>()),
          // ChangeNotifierProvider<LoggerProvider>(
          //     create: (_) => LoggerProvider.instance),
          // ChangeNotifierProvider<AuthenticationProvider>(
          //     create: (_) => AuthenticationProvider.instance),
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
