// register_controller.dart
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:remind_me_fe/core/snackBar/snack_bar.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/register_credentials.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/auth_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

class RegisterController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  late AuthProvider provider;

  RegisterController() {
    provider = sl<AuthProvider>();
  }

  Future<void> handleRegister(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      RegisterCredentials credentials = RegisterCredentials(
        email: emailController.text,
        password: passwordController.text,
        nickname: usernameController.text,
      );

      var result = await provider.register(credentials);

      if (result.httpStatusCode == HttpStatus.created) {
        Navigator.pushNamed(context, Routes.loginRoute);
      } else if (result.httpStatusCode == HttpStatus.badRequest) {
        buildSnackBarMessage(context, "'Bad credentials. Please try again.'");
      } else {
        buildSnackBarMessage(
            context, 'Unexpected error occurred. Try again later.');
      }
    } else {
      buildSnackBarMessage(context, 'Please fill in all input fields.');
    }
  }
}
