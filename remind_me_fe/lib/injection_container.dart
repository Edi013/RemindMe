import 'package:get_it/get_it.dart';
import 'package:remind_me_fe/core/interceptors/authentication_interceptor.dart';
import 'package:remind_me_fe/features/authentication/data/data_sources/remote/auth_service_api.dart';
import 'package:remind_me_fe/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/auth_provider.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/features/theme/data/local/current_app_theme.dart';
import 'package:remind_me_fe/features/list_todos/data/data_sources/remote/todo_service_api.dart';
import 'package:remind_me_fe/features/list_todos/data/repositories/todo_repository_impl.dart';
import 'package:remind_me_fe/features/theme/presentation/providers/theme_provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/list_todos/presentation/providers/todo_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio(BaseOptions(headers: {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*',
  })));
  sl<Dio>().interceptors.add(AuthenticationInterceptor());

  sl.registerSingleton<AppTheme>(AppTheme());
  sl.registerSingleton<ThemeProvider>(ThemeProvider(sl<AppTheme>()));

  sl.registerSingleton<TodoServiceApi>(TodoServiceApi());
  sl.registerSingleton<TodoRepositoryImpl>(
      TodoRepositoryImpl(sl<TodoServiceApi>()));
  sl.registerSingleton<TodoProvider>(TodoProvider(sl<TodoRepositoryImpl>()));

  sl.registerSingleton<CurrentUser>(CurrentUser(null));
  sl.registerSingleton<AuthServiceApi>(AuthServiceApi());
  sl.registerSingleton<AuthRepositoryImpl>(
      AuthRepositoryImpl(sl<AuthServiceApi>()));
  sl.registerSingleton<AuthProvider>(AuthProvider(sl<AuthRepositoryImpl>()));

  sl.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}
