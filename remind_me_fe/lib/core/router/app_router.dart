import 'package:auto_route/auto_route.dart';
import 'package:remind_me_fe/core/router/guards/auth_guard.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/injection_container.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: !sl<CurrentUser>().isJwtExpired() ? true : false,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: LoginRoute.page,
          initial: sl<CurrentUser>().isJwtExpired() ? true : false,
          keepHistory: false,
        ),
        AutoRoute(
          page: RegisterRoute.page,
          keepHistory: false,
        ),
        AutoRoute(
          page: SessionExpiredRoute.page,
          keepHistory: false,
        ),
        AutoRoute(
          page: LogoutRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: ThemeRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: ChangeStartupRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: TodoAddRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: TodoListRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: TodoUpdateRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: UserProfileRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: ActiveTodosRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: DoneTodosRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: UndoneTodosRoute.page,
          guards: [AuthGuard()],
        ),
      ];
}
