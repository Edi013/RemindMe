import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  late TextEditingController _passwordController;
  late String _fieldName;

  PasswordFormField(TextEditingController passwordController, String fieldName,
      {Key? key})
      : super(key: key) {
    _passwordController = passwordController;
    _fieldName = fieldName;
  }

  @override
  _PasswordFormFieldState createState() =>
      _PasswordFormFieldState(_passwordController, _fieldName);
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;
  late TextEditingController _passwordController;
  late String _fieldName;

  _PasswordFormFieldState(
      TextEditingController passwordController, String fieldName) {
    _passwordController = passwordController;
    _fieldName = fieldName;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: _fieldName,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: _togglePasswordVisibility,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your ${_fieldName.toLowerCase()}';
        }
        return null;
      },
    );
  }
}
