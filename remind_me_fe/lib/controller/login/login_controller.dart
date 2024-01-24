import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> keepLoggedInNotifier = ValueNotifier<bool>(false);

  String get email => emailController.text;
  String get password => passwordController.text;
  bool get keepLoggedIn => keepLoggedInNotifier.value;

  void login(BuildContext context) {
    // Implement your login logic here
    // You can access the email, password, and keepLoggedIn variables
    // from this controller to perform authentication

    // For example:
    if (email == 'user@example.com' && password == 'password') {
      // Successful login
      // Redirect to the next screen or perform other actions
      print('Login successful');
    } else {
      // Failed login
      // Show an error message or perform other actions
      print('Login failed');
    }
  }

  void forgotPassword(BuildContext context) {
    // Implement your 'Forgot Password' logic here
    // For example, navigate to a screen for password recovery
    print('Forgot Password clicked');
  }
}
