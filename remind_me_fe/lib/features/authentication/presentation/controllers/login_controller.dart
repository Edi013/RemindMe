// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:remind_me_fe/core/snackBar/snack_bar.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_credentials.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/auth_provider.dart';

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
        _saveUserAuthenticationData(result.token);
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

  Future<void> _saveUserAuthenticationData(String token) async {
    provider.currentUser.parseNewJwt(token);
  }
}
