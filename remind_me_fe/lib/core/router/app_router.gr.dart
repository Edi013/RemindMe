// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:remind_me_fe/features/authentication/presentation/screens/expired_session_screen.dart'
    as _i8;
import 'package:remind_me_fe/features/authentication/presentation/screens/login_screen.dart'
    as _i5;
import 'package:remind_me_fe/features/authentication/presentation/screens/logout_screen.dart'
    as _i6;
import 'package:remind_me_fe/features/authentication/presentation/screens/register_screen.dart'
    as _i7;
import 'package:remind_me_fe/features/home/presentation/change_startup_screen.dart'
    as _i2;
import 'package:remind_me_fe/features/home/presentation/home_screen.dart'
    as _i4;
import 'package:remind_me_fe/features/theme/presentation/screens/theme_screen.dart'
    as _i9;
import 'package:remind_me_fe/features/todos/presentation/screens/active_todos_screen.dart'
    as _i1;
import 'package:remind_me_fe/features/todos/presentation/screens/all_todos_screens/todo_add_screen.dart'
    as _i10;
import 'package:remind_me_fe/features/todos/presentation/screens/all_todos_screens/todo_list_screen.dart'
    as _i11;
import 'package:remind_me_fe/features/todos/presentation/screens/all_todos_screens/todo_update_screen.dart'
    as _i12;
import 'package:remind_me_fe/features/todos/presentation/screens/done_todos_screen.dart'
    as _i3;
import 'package:remind_me_fe/features/todos/presentation/screens/undone_todos_screen.dart'
    as _i13;
import 'package:remind_me_fe/features/user_profile/presentation/screens/user_profile_screen.dart'
    as _i14;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    ActiveTodosRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ActiveTodosScreen(),
      );
    },
    ChangeStartupRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ChangeStartupScreen(),
      );
    },
    DoneTodosRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DoneTodosScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.LoginScreen(key: args.key),
      );
    },
    LogoutRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LogoutScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.RegisterScreen(),
      );
    },
    SessionExpiredRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SessionExpiredScreen(),
      );
    },
    ThemeRoute.name: (routeData) {
      final args = routeData.argsAs<ThemeRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.ThemeScreen(
          args.context,
          key: args.key,
        ),
      );
    },
    TodoAddRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.TodoAddScreen(),
      );
    },
    TodoListRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.TodoListScreen(),
      );
    },
    TodoUpdateRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TodoUpdateRouteArgs>(
          orElse: () => TodoUpdateRouteArgs(
                index: pathParams.getInt('index'),
                todoId: pathParams.getInt('todoId'),
                listName: pathParams.getString('listName'),
              ));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.TodoUpdateScreen(
          key: args.key,
          index: args.index,
          todoId: args.todoId,
          listName: args.listName,
        ),
      );
    },
    UndoneTodosRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.UndoneTodosScreen(),
      );
    },
    UserProfileRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.UserProfileScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ActiveTodosScreen]
class ActiveTodosRoute extends _i15.PageRouteInfo<void> {
  const ActiveTodosRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ActiveTodosRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActiveTodosRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChangeStartupScreen]
class ChangeStartupRoute extends _i15.PageRouteInfo<void> {
  const ChangeStartupRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ChangeStartupRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeStartupRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DoneTodosScreen]
class DoneTodosRoute extends _i15.PageRouteInfo<void> {
  const DoneTodosRoute({List<_i15.PageRouteInfo>? children})
      : super(
          DoneTodosRoute.name,
          initialChildren: children,
        );

  static const String name = 'DoneTodosRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginScreen]
class LoginRoute extends _i15.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i15.PageInfo<LoginRouteArgs> page =
      _i15.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.LogoutScreen]
class LogoutRoute extends _i15.PageRouteInfo<void> {
  const LogoutRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LogoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'LogoutRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.RegisterScreen]
class RegisterRoute extends _i15.PageRouteInfo<void> {
  const RegisterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SessionExpiredScreen]
class SessionExpiredRoute extends _i15.PageRouteInfo<void> {
  const SessionExpiredRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SessionExpiredRoute.name,
          initialChildren: children,
        );

  static const String name = 'SessionExpiredRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ThemeScreen]
class ThemeRoute extends _i15.PageRouteInfo<ThemeRouteArgs> {
  ThemeRoute({
    required _i16.BuildContext context,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ThemeRoute.name,
          args: ThemeRouteArgs(
            context: context,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ThemeRoute';

  static const _i15.PageInfo<ThemeRouteArgs> page =
      _i15.PageInfo<ThemeRouteArgs>(name);
}

class ThemeRouteArgs {
  const ThemeRouteArgs({
    required this.context,
    this.key,
  });

  final _i16.BuildContext context;

  final _i16.Key? key;

  @override
  String toString() {
    return 'ThemeRouteArgs{context: $context, key: $key}';
  }
}

/// generated route for
/// [_i10.TodoAddScreen]
class TodoAddRoute extends _i15.PageRouteInfo<void> {
  const TodoAddRoute({List<_i15.PageRouteInfo>? children})
      : super(
          TodoAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'TodoAddRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i11.TodoListScreen]
class TodoListRoute extends _i15.PageRouteInfo<void> {
  const TodoListRoute({List<_i15.PageRouteInfo>? children})
      : super(
          TodoListRoute.name,
          initialChildren: children,
        );

  static const String name = 'TodoListRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.TodoUpdateScreen]
class TodoUpdateRoute extends _i15.PageRouteInfo<TodoUpdateRouteArgs> {
  TodoUpdateRoute({
    _i16.Key? key,
    required int index,
    required int todoId,
    required String listName,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          TodoUpdateRoute.name,
          args: TodoUpdateRouteArgs(
            key: key,
            index: index,
            todoId: todoId,
            listName: listName,
          ),
          rawPathParams: {
            'index': index,
            'todoId': todoId,
            'listName': listName,
          },
          initialChildren: children,
        );

  static const String name = 'TodoUpdateRoute';

  static const _i15.PageInfo<TodoUpdateRouteArgs> page =
      _i15.PageInfo<TodoUpdateRouteArgs>(name);
}

class TodoUpdateRouteArgs {
  const TodoUpdateRouteArgs({
    this.key,
    required this.index,
    required this.todoId,
    required this.listName,
  });

  final _i16.Key? key;

  final int index;

  final int todoId;

  final String listName;

  @override
  String toString() {
    return 'TodoUpdateRouteArgs{key: $key, index: $index, todoId: $todoId, listName: $listName}';
  }
}

/// generated route for
/// [_i13.UndoneTodosScreen]
class UndoneTodosRoute extends _i15.PageRouteInfo<void> {
  const UndoneTodosRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UndoneTodosRoute.name,
          initialChildren: children,
        );

  static const String name = 'UndoneTodosRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.UserProfileScreen]
class UserProfileRoute extends _i15.PageRouteInfo<void> {
  const UserProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
