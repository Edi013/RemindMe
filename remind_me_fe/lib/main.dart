import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:remind_me_fe/core/theme/current_app_theme.dart';
import 'package:remind_me_fe/core/theme/theme_config.dart';
import 'package:remind_me_fe/features/list_todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/features/theme/presentation/providers/theme_provider.dart';
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
          ChangeNotifierProvider<ThemeProvider>(
              create: (_) => sl<ThemeProvider>()),
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
      debugShowCheckedModeBanner: false,
      title: 'RemindMe',
      initialRoute: Routes.themeScreenRoute,
      routes: Routes.generateRoutes(),
      theme:
          lightTheme, //Provider.of<ThemeProvider>(context).appTheme.currentThemeData,
      darkTheme:
          darkTheme, //Provider.of<ThemeProvider>(context).appTheme.currentThemeData,
      themeMode: Provider.of<ThemeProvider>(context).buildThemeMode(),
    );
  }

  ThemeMode buildThemeMode(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }
}
