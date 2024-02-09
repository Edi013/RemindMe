import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_credentials.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_result.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/register_credentials.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/base_response.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepositoryImpl repository;
  late CurrentUser currentUser;

  AuthProvider(AuthRepositoryImpl repo) {
    repository = repo;
  }

  Future<LoginResponse> login(LoginCredentials credentials) async {
    var result = await repository.login(credentials);
    return result;
  }

  Future<BaseResult> register(RegisterCredentials credentials) async {
    var result = await repository.register(credentials);
    return result;
  }
}
