import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:remind_me_fe/core/theme/theme_config.dart';
import 'package:remind_me_fe/features/authentication/presentation/controllers/register_controller.dart';
import 'package:remind_me_fe/features/authentication/presentation/widgets/password_form_field.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "../../../../assets/images/pier-lake-hallstatt-austria.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: RegisterCard(context),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RegisterCard extends StatelessWidget {
  late RegisterController controller;

  RegisterCard(BuildContext context, {super.key}) {
    controller = RegisterController();
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
                  "Register",
                  style: TextStyle(
                    fontSize: 32,
                    decorationStyle: TextDecorationStyle.solid,
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
                        child: TextFormField(
                          controller: controller.usernameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Nickname",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your nickname';
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
                          vertical: 16,
                        ),
                        child: PasswordFormField(
                            controller.confirmPasswordController,
                            'Confirm password'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16.0,
                        ),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller.handleRegister(context);
                            },
                            child: const Text('Register'),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          AutoRouter.of(context).push(LoginRoute());
                        },
                        child: const Text(
                          "You already have an account ?",
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
