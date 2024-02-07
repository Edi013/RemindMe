import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/auth_provider.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  late AuthProvider provider;

  HomeScreen(AuthProvider authProvider, {super.key}) {
    provider = authProvider;
  }

  @override
  Widget build(BuildContext context) {
    checkJwtValidity(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.todoListRoute);
          },
          child: const Text('Go to Todo List'),
        ),
      ),
    );
  }

  void checkJwtValidity(BuildContext context) {
    provider.clearJwtData(sl<SharedPreferences>());
    if (!provider.isJwtPresent()) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.sessionExpiredRoute,
        (route) => false, // Remove all routes and push login route
      );
    }
    if (provider.isJwtExpired()) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.sessionExpiredRoute,
        (route) => false, // Remove all routes and push login route
      );
    }
    return;
  }
}
