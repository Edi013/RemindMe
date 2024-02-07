import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_credentials.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_result.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/register_credentials.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/user.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/base_response.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepositoryImpl repository;
  late User currentUser;

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

  bool isJwtPresent() {
    var preferences = sl<SharedPreferences>();

    if (preferences.getString(jwt_key) == null) {
      return false;
    }
    return preferences.getString(jwt_key)!.isEmpty ? false : true;
  }

  bool isJwtExpired() {
    var preferences = sl<SharedPreferences>();
    var jwtExpirationDate = preferences.getString(jwt_expiration_date_key);

    if (jwtExpirationDate == null) {
      return true;
    }
    if (jwtExpirationDate.isEmpty) {
      clearJwtData(preferences);
      return true;
    }

    var jwtExpirationDateParsed = DateTime.parse(jwtExpirationDate);
    if (jwtExpirationDateParsed.isBefore(DateTime.now().toUtc())) {
      clearJwtData(preferences);
      return true;
    }

    return false;
  }

  void clearJwtData(SharedPreferences preferences) {
    preferences.remove(jwt_key);
    preferences.remove(jwt_expiration_date_key);
  }
}
