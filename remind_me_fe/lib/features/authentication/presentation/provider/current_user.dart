import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser {
  final SharedPreferences preferences = sl<SharedPreferences>();
  late String? jwt;
  late DateTime? jwtExpirationDate;
  late String? jwtJti;
  late String? nickname;
  late String? email;
  late List<String>? role;

  CurrentUser();

  void parseNewJwt(String token) {
    {
      if (token == jwt || token.isEmpty) {
        return;
      }

      JWTData jwtData = jwtDecode(token);
      if (jwtData.expiration == null) {
        return;
      }

      if (!jwtData.expiration!.isBefore(DateTime.now().toUtc())) {
        return;
      }

      jwt = token;
      jwtExpirationDate = jwtData.expiration!;
      jwtJti = jwtData.payload[jwt_jti] as String;
      nickname = jwtData.payload[jwt_nickname] as String;
      email = jwtData.payload[jwt_email] as String;
      var roleFromJwt = jwtData.payload[jwt_role];
      for (var role in roleFromJwt) {
        this.role.insert(this.role.length, role);
      }
    }
  }

  bool isJwtPresent() {
    var jwt = preferences.getString(jwt_key);
    if (jwt == null || jwt.isEmpty) {
      return false;
    }

    return true;
  }

  bool isJwtExpired() {
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
