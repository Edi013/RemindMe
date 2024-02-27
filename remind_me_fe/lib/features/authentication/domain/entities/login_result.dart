import 'package:remind_me_fe/features/authentication/domain/entities/base_response.dart';

class LoginResponse implements BaseResult {
  @override
  late int httpStatusCode;

  @override
  late String message;

  late String token;
  late String jwtExpiration;

  LoginResponse({
    required this.httpStatusCode,
    required this.message,
    required this.token,
    required this.jwtExpiration,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      httpStatusCode: json['httpStatusCode'] as int,
      message: json['message'] as String,
      token: json['jwt'] as String,
      jwtExpiration: json['jwtExpiration'] as String,
    );
  }
}
