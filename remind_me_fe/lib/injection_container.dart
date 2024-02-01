import 'package:get_it/get_it.dart';
import 'package:remind_me_fe/features/list_todos/data/data_sources/remote/todo_service_api.dart';
import 'package:remind_me_fe/features/list_todos/data/repositories/todo_repository_impl.dart';

import 'features/list_todos/presentation/providers/todo_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<TodoServiceApi>(TodoServiceApi());
  sl.registerSingleton<TodoRepositoryImpl>(
      TodoRepositoryImpl(sl<TodoServiceApi>()));
  sl.registerSingleton<TodoProvider>(TodoProvider());
}
