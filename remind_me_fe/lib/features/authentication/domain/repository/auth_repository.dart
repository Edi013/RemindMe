import 'package:remind_me_fe/features/authentication/domain/entities/base_response.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_credentials.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/register_credentials.dart';

abstract class AuthRepository {
  Future<BaseResponse> register(RegisterCredentials credentials);
  Future<BaseResponse> login(LoginCredentials credentials);
  Future<String> test();
}
