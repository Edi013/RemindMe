import 'package:dio/dio.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/injection_container.dart';

class AuthenticationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    CurrentUser currentUser = sl<CurrentUser>();

    if (currentUser.isJwtPresent()) {
      options.headers['Authorization'] = 'Bearer ${currentUser.jwt}';
    }

    super.onRequest(options, handler);
  }
}
