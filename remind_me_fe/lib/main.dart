import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/core/router/app_router.dart';
import 'package:remind_me_fe/core/theme/theme_config.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/auth_provider.dart';
import 'package:remind_me_fe/features/todos/presentation/providers/todo_provider.dart';
import 'package:remind_me_fe/features/theme/presentation/providers/theme_provider.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  try {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<TodoProvider>(
              create: (_) => sl<TodoProvider>()),
          ChangeNotifierProvider<ThemeProvider>(
              create: (_) => sl<ThemeProvider>()),
          ChangeNotifierProvider<AuthProvider>(
              create: (_) => sl<AuthProvider>()),
        ],
        child: MyApp(),
      ),
    );

    if (!kIsWeb) {
      doWhenWindowReady(() {
        appWindow.minSize = const Size(500, 500);
      });
    }
  } catch (e, stackTrace) {
    // ignore: avoid_print
    print("Error: $e + Stacktrace: $stackTrace");
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'RemindMe',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).buildAppThemeMode(),
      routerConfig: _appRouter.config(),
    );
  }
}
