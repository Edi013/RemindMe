import 'package:dio/dio.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString(jwt_key);

    if (jwtToken != null) {
      options.headers['Authorization'] = 'Bearer $jwtToken';
    }

    super.onRequest(options, handler);
  }
}
