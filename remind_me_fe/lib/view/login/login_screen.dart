import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email Field
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 16.0),

            // Password Field
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(height: 16.0),

            // Keep me logged in Checkbox
            Row(
              children: [
                Checkbox(
                  value: false, // Set the initial value accordingly
                  onChanged: (bool? value) {
                    // Handle checkbox value change
                  },
                ),
                Text('Keep me logged in'),
              ],
            ),
            SizedBox(height: 16.0),

            // Forgot Password Text
            GestureDetector(
              onTap: () {
                // Handle the 'Forgot Password' action
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 32.0),

            // Login Button
            ElevatedButton(
              onPressed: () {
                // Handle the login action
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}