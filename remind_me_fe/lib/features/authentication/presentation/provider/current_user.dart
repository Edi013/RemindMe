import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser {
  late final SharedPreferences preferences;
  late String? jwt;
  late DateTime? jwtExpirationDate;
  late String? jwtJti;
  late String? nickname;
  late String? email;
  late List<String>? role;

  CurrentUser(SharedPreferences preferencesInjected) {
    preferences = preferencesInjected;

    jwt = preferences.getString(jwt_key);
  }

  void parseNewJwt(String token) {
    {
      if (token == jwt || token.isEmpty) {
        throw AssertionError("Token was empty when login was in progress.");
      }

      JWTData jwtData = jwtDecode(token);
      if (jwtData.expiration == null) {
        throw AssertionError("Token has no expiration date.");
      }

      if (!jwtData.expiration!.isBefore(DateTime.now().toUtc())) {
        return;
      }

      _saveJwt(token);
      _saveJwtData(jwtData);
    }
  }

  void _saveJwt(String token) {
    preferences.setString(jwt_key, token);
    jwt = token;
  }

  void _saveJwtData(JWTData jwtData) {
    jwtExpirationDate = jwtData.expiration!;
    jwtJti = jwtData.payload[jwt_jti] as String;
    nickname = jwtData.payload[jwt_nickname] as String;
    email = jwtData.payload[jwt_email] as String;
    var roleFromJwt = jwtData.payload[jwt_role];
    for (var role in roleFromJwt) {
      this.role!.insert(this.role!.length, role);
    }
  }

  bool isJwtPresent() {
    if (jwt == null) {
      return false;
    }
    if (jwt!.isEmpty) {
      return false;
    }

    return true;
  }

  bool isJwtExpired() {
    if (!isJwtPresent()) {
      return true;
    }
    if (jwtExpirationDate == null) {
      return true;
    }

    if (jwtExpirationDate!.isBefore(DateTime.now().toUtc())) {
      clearJwtData();
      return true;
    }
    return false;
  }

  void clearJwtData() {
    preferences.remove(jwt_key);
    jwt = null;
    jwtExpirationDate = null;
    jwtJti = null;
    nickname = null;
    email = null;
    role = null;
  }
}