import 'package:remind_me_fe/features/authentication/domain/entities/base_response.dart';

class LoginResponse implements BaseResult {
  @override
  late int httpStatusCode;

  @override
  late String message;

  late String token;

  LoginResponse({
    required this.httpStatusCode,
    required this.message,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json, String token) {
    return LoginResponse(
      token: token,
      httpStatusCode: json['httpStatusCode'] as int,
      message: json['message'] as String,
    );
  }
}
