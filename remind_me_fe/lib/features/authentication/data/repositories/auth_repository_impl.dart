import 'package:remind_me_fe/features/authentication/data/data_sources/remote/auth_service_api.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/base_response.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_credentials.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/register_credentials.dart';
import 'package:remind_me_fe/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  late AuthServiceApi authService;

  AuthRepositoryImpl(AuthServiceApi service) {
    authService = service;
  }

  @override
  Future<BaseResponse> login(LoginCredentials credentials) async {
    return await authService.login(credentials);
  }

  @override
  Future<BaseResponse> register(RegisterCredentials credentials) async {
    return await authService.register(credentials);
  }

  @override
  Future<String> test() async {
    return await authService.test();
  }
}
