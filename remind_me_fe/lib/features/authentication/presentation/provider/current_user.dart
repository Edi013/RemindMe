import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser {
  late final SharedPreferences preferences;
  String? id;
  String? jwt;
  DateTime? jwtExpirationDate;
  String? jwtJti;
  String? nickname;
  String? email;
  List<String> roles = [];

  CurrentUser(SharedPreferences preferencesInjected) {
    preferences = preferencesInjected;
    var storedJwt = preferences.getString(jwt_key);
    if (storedJwt != null && storedJwt.isNotEmpty) {
      parseNewJwt(storedJwt);
      return;
    }
    id = null;
    jwt = null;
    jwtExpirationDate = null;
    jwtJti = null;
    nickname = "User";
    email = null;
    roles = [];
  }

  bool isLoggedIn() {
    if (!isJwtPresent()) {
      clearJwtData();
      return false;
    }
    if (isJwtExpired()) {
      clearJwtData();
      return false;
    }

    return true;
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

      if (jwtData.expiration!.isBefore(DateTime.now().toUtc())) {
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
    id = jwtData.payload[jwt_user_id];
    jwtExpirationDate = jwtData.expiration!;
    jwtJti = jwtData.payload[jwt_jti] as String;
    nickname = jwtData.payload[jwt_nickname] as String;
    email = jwtData.payload[jwt_email] as String;

    var roleFromJwt = jwtData.payload[jwt_role];
    if (roleFromJwt is String) {
      roles.add(roleFromJwt);
    } else if (roleFromJwt is List<String>) {
      // role = roleFromJwt;
      for (var role in roleFromJwt) {
        roles.add(role);
      }
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
    id = null;
    jwt = null;
    jwtExpirationDate = null;
    jwtJti = null;
    nickname = null;
    email = null;
    roles = [];
  }
}
