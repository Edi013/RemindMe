import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/routes.dart';

class SessionExpiredScreen extends StatelessWidget {
  const SessionExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Expired'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Session has expired.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'You need to log in.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
