// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:remind_me_fe/core/home/home_screen.dart' as _i1;
import 'package:remind_me_fe/features/authentication/presentation/screens/expired_session_screen.dart'
    as _i5;
import 'package:remind_me_fe/features/authentication/presentation/screens/login_screen.dart'
    as _i2;
import 'package:remind_me_fe/features/authentication/presentation/screens/logout_screen.dart'
    as _i3;
import 'package:remind_me_fe/features/authentication/presentation/screens/register_screen.dart'
    as _i4;
import 'package:remind_me_fe/features/theme/presentation/screens/theme_screen.dart'
    as _i6;
import 'package:remind_me_fe/features/todos/presentation/screens/todo_add_screen.dart'
    as _i7;
import 'package:remind_me_fe/features/todos/presentation/screens/todo_list_screen.dart'
    as _i8;
import 'package:remind_me_fe/features/todos/presentation/screens/todo_update_screen.dart'
    as _i9;
import 'package:remind_me_fe/features/user_profile/presentation/screens/user_profile_screen.dart'
    as _i10;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.LoginScreen(key: args.key),
      );
    },
    LogoutRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LogoutScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterScreen(),
      );
    },
    SessionExpiredRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SessionExpiredScreen(),
      );
    },
    ThemeRoute.name: (routeData) {
      final args = routeData.argsAs<ThemeRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.ThemeScreen(
          args.context,
          key: args.key,
        ),
      );
    },
    TodoAddRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.TodoAddScreen(),
      );
    },
    TodoListRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.TodoListScreen(),
      );
    },
    TodoUpdateRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TodoUpdateRouteArgs>(
          orElse: () => TodoUpdateRouteArgs(
                index: pathParams.getInt('index'),
                todoId: pathParams.getInt('todoId'),
              ));
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.TodoUpdateScreen(
          key: args.key,
          index: args.index,
          todoId: args.todoId,
        ),
      );
    },
    UserProfileRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.UserProfileScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i11.PageInfo<LoginRouteArgs> page =
      _i11.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.LogoutScreen]
class LogoutRoute extends _i11.PageRouteInfo<void> {
  const LogoutRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LogoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'LogoutRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.RegisterScreen]
class RegisterRoute extends _i11.PageRouteInfo<void> {
  const RegisterRoute({List<_i11.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SessionExpiredScreen]
class SessionExpiredRoute extends _i11.PageRouteInfo<void> {
  const SessionExpiredRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SessionExpiredRoute.name,
          initialChildren: children,
        );

  static const String name = 'SessionExpiredRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ThemeScreen]
class ThemeRoute extends _i11.PageRouteInfo<ThemeRouteArgs> {
  ThemeRoute({
    required _i12.BuildContext context,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          ThemeRoute.name,
          args: ThemeRouteArgs(
            context: context,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ThemeRoute';

  static const _i11.PageInfo<ThemeRouteArgs> page =
      _i11.PageInfo<ThemeRouteArgs>(name);
}

class ThemeRouteArgs {
  const ThemeRouteArgs({
    required this.context,
    this.key,
  });

  final _i12.BuildContext context;

  final _i12.Key? key;

  @override
  String toString() {
    return 'ThemeRouteArgs{context: $context, key: $key}';
  }
}

/// generated route for
/// [_i7.TodoAddScreen]
class TodoAddRoute extends _i11.PageRouteInfo<void> {
  const TodoAddRoute({List<_i11.PageRouteInfo>? children})
      : super(
          TodoAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'TodoAddRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i8.TodoListScreen]
class TodoListRoute extends _i11.PageRouteInfo<void> {
  const TodoListRoute({List<_i11.PageRouteInfo>? children})
      : super(
          TodoListRoute.name,
          initialChildren: children,
        );

  static const String name = 'TodoListRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i9.TodoUpdateScreen]
class TodoUpdateRoute extends _i11.PageRouteInfo<TodoUpdateRouteArgs> {
  TodoUpdateRoute({
    _i12.Key? key,
    required int index,
    required int todoId,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          TodoUpdateRoute.name,
          args: TodoUpdateRouteArgs(
            key: key,
            index: index,
            todoId: todoId,
          ),
          rawPathParams: {
            'index': index,
            'todoId': todoId,
          },
          initialChildren: children,
        );

  static const String name = 'TodoUpdateRoute';

  static const _i11.PageInfo<TodoUpdateRouteArgs> page =
      _i11.PageInfo<TodoUpdateRouteArgs>(name);
}

class TodoUpdateRouteArgs {
  const TodoUpdateRouteArgs({
    this.key,
    required this.index,
    required this.todoId,
  });

  final _i12.Key? key;

  final int index;

  final int todoId;

  @override
  String toString() {
    return 'TodoUpdateRouteArgs{key: $key, index: $index, todoId: $todoId}';
  }
}

/// generated route for
/// [_i10.UserProfileScreen]
class UserProfileRoute extends _i11.PageRouteInfo<void> {
  const UserProfileRoute({List<_i11.PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
