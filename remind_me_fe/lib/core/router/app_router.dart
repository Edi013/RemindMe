import 'package:auto_route/auto_route.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/injection_container.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: LoginRoute.page,
            initial: sl<CurrentUser>().isJwtExpired() ? true : false),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: LogoutRoute.page),
        AutoRoute(page: SessionExpiredRoute.page),
        AutoRoute(page: ThemeRoute.page),
        AutoRoute(page: TodoAddRoute.page),
        AutoRoute(page: TodoListRoute.page),
        AutoRoute(page: TodoUpdateRoute.page),
        AutoRoute(page: UserProfileRoute.page),
        AutoRoute(
            page: HomeRoute.page,
            initial: !sl<CurrentUser>().isJwtExpired() ? true : false),
      ];
}
