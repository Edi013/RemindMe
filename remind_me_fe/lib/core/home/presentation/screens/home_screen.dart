import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class HomeScreenWithJwtCheck extends StatefulWidget {
  final AuthProvider provider;

  const HomeScreenWithJwtCheck(this.provider, {Key? key}) : super(key: key);

  @override
  _HomeScreenWithJwtCheckState createState() => _HomeScreenWithJwtCheckState();
}

class _HomeScreenWithJwtCheckState extends State<HomeScreenWithJwtCheck> {
  @override
  void initState() {
    super.initState();

    manageAuthentionStatus(context);
  }

  void manageAuthentionStatus(BuildContext context) {
    if (!widget.provider.currentUser.isJwtPresent()) {
      _navigateToLogin(context);
    }
    if (widget.provider.currentUser.isJwtExpired()) {
      _navigateToLogin(context);
    }
    return;
  }

  void _navigateToLogin(BuildContext context) {
    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   Routes.sessionExpiredRoute,
    //   (route) => false,
    // );
    Navigator.pushNamed(context, Routes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
