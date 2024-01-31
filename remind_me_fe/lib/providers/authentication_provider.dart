import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AuthenticationProvider.singleton() {
    initialize();
  }

  static final AuthenticationProvider _instance =
      AuthenticationProvider.singleton();

  static AuthenticationProvider get instance => _instance;

  initialize() {}

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
