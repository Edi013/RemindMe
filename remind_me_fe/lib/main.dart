import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        child: MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    // ignore: avoid_print
    print("Error: $e + Stacktrace: $stackTrace");
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      data: sl<AppTheme>().currentThemeData,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RemindMe',
        initialRoute: Routes.themeScreenRoute,
        routes: Routes.generateRoutes(),
        theme: MyInheritedWidget.of(context)!.data,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final ThemeData data;

  MyInheritedWidget({required this.data, required Widget child})
      : super(child: child);

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return oldWidget.data != data;
  }
}
