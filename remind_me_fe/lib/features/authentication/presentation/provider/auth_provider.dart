import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_credentials.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_result.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/register_credentials.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/user.dart';

import '../../domain/entities/base_response.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepositoryImpl repository;
  late User currentUser;

  AuthProvider(AuthRepositoryImpl repo) {
    repository = repo;
  }

  Future<String> test() async {
    return await repository.test();
  }

  Future<LoginResponse> login(LoginCredentials credentials) async {
    var result = await repository.login(credentials);
    // store jwt
    return result;
  }

  Future<BaseResult> register(RegisterCredentials credentials) async {
    var result = await repository.register(credentials);
    return result;
  }
}
