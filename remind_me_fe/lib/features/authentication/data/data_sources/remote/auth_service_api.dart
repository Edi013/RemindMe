import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/base_response.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_credentials.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_result.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/register_credentials.dart';
import 'package:remind_me_fe/injection_container.dart';

class AuthServiceApi {
  final String apiExtension = '/Authentication';
  late String apiUrl;
  late Dio _dio;

  AuthServiceApi() {
    apiUrl = "$BASE_URL_AUTHENTICATION_SERVICE$apiExtension";
    _dio = sl<Dio>();
  }

  Future<LoginResponse> login(LoginCredentials credentials) async {
    try {
      final response =
          await _dio.post('$apiUrl/Login', data: credentials.toJson());
      if (response.statusCode == 400) {
        return LoginResponse(
          httpStatusCode: 400,
          message: "Bad credentials",
          jwtExpiration: "",
          token: "",
        );
      }
      return LoginResponse.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }

  Future<BaseResult> register(RegisterCredentials credentials) async {
    try {
      final response =
          await _dio.post('$apiUrl/Register', data: credentials.toJson());
      if (response.statusCode == 400) {
        return BaseResult(
          httpStatusCode: 400,
          message: "Bad credentials",
        );
      }
      return BaseResult.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to register: $error');
    }
  }
}
