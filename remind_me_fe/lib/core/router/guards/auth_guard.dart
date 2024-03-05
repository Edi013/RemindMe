import 'package:auto_route/auto_route.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/injection_container.dart';

class AuthGuard extends AutoRouteGuard {
  late CurrentUser currentUser;

  AuthGuard() {
    currentUser = sl<CurrentUser>();
  }

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    if (currentUser.isLoggedIn()) {
      resolver.next(true);
    } else {
      router.push(LoginRoute());
    }
  }
}
