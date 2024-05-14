import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:remind_me_fe/core/theme/theme_config.dart';
import 'package:remind_me_fe/features/authentication/presentation/controllers/login_controller.dart';
import 'package:remind_me_fe/features/authentication/presentation/widgets/password_form_field.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "../../../../assets/images/pier-lake-hallstatt-austria.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: LoginCard(),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LoginCard extends StatelessWidget {
  late LoginController controller;

  LoginCard({super.key}) {
    controller = LoginController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 750),
        child: Card(
          color: black.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 32,
                    decorationStyle: TextDecorationStyle.solid,
                    color: white,
                  ),
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        child: TextFormField(
                          controller: controller.emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email",
                            fillColor: white,
                            iconColor: white,
                            hoverColor: white,
                            suffixIconColor: white,
                            prefixIconColor: white,
                            focusColor: white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains("@")) {
                              return 'Email has to contain this symbol @ ';
                            }
                            if (!value.endsWith('.com')) {
                              return 'Email has to end in .com';
                            }
                            if (value.endsWith('@.com')) {
                              return 'Email has to have a domain specified. Avoid using @.com';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        child: PasswordFormField(
                            controller.passwordController, 'Password'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16.0,
                        ),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller.handleLogin(context);
                            },
                            style: ElevatedButton.styleFrom(),
                            child: const Text('Submit'),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          AutoRouter.of(context).push(const RegisterRoute());
                        },
                        child: const Text(
                          "Don't have an accout ?",
                          style: TextStyle(color: white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
