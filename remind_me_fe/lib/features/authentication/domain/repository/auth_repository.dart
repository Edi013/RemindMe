import 'package:remind_me_fe/features/authentication/domain/entities/base_response.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_credentials.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/register_credentials.dart';

abstract class AuthRepository {
  Future<BaseResult> register(RegisterCredentials credentials);
  Future<BaseResult> login(LoginCredentials credentials);
  Future<String> test();
}
