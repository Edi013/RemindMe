// login_controller.dart
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:remind_me_fe/core/snackBar/snack_bar.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_credentials.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/auth_provider.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late AuthProvider provider;

  LoginController(AuthProvider providerInjected) {
    provider = providerInjected;
  }

  Future<void> handleLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      LoginCredentials credentials = LoginCredentials(
        email: emailController.text,
        password: passwordController.text,
      );

      var result = await provider.login(credentials);

      if (result.httpStatusCode == HttpStatus.accepted) {
        Navigator.pushNamed(context, Routes.homeRoute);
        _saveUserAuthenticationData(result.token, result.jwtExpiration);
      } else if (result.httpStatusCode == HttpStatus.badRequest) {
        buildSnackBarMessage(context, "'Bad credentials. Please try again.'");
      } else {
        buildSnackBarMessage(context,
            "Unexpected error occured. Http code status not expected.");
      }
    } else {
      buildSnackBarMessage(context, "Fill in your credentials.");
    }
  }

  Future<void> _saveUserAuthenticationData(
      String token, String expirationDateUtc) async {
    if (token.isEmpty) {
      throw AssertionError("Token was empty when storing it have been tried.");
    }
    if (expirationDateUtc.isEmpty) {
      throw AssertionError(
          "Expiration date for token was empty when storing it have been tried.");
    }

    final SharedPreferences preferences = sl<SharedPreferences>();
    preferences.setString(jwt_key, token);
    preferences.setString(jwt_expiration_date_key, expirationDateUtc);
  }
}
