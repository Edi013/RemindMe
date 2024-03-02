import 'package:flutter/material.dart';
import 'package:remind_me_fe/features/authentication/presentation/controllers/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RegisterCard(context),
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
    return Container(
      constraints: const BoxConstraints(maxWidth: 750),
      child: Card(
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
                            return 'Email has to contain \' @ \'.';
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
                      child: TextFormField(
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
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
                        controller: controller.confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Confirm Password",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != controller.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
