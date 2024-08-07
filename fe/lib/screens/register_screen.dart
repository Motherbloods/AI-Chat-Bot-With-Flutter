import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Color(0xFF81A263),
        foregroundColor: Color(0xFFF8EDE3),
      ),
      body: Container(
        color: Color(0xFFF8EDE3),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Color(0xFF81A263)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF81A263)),
                ),
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Color(0xFF81A263)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF81A263)),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _authController.register(
                  _usernameController.text,
                  _passwordController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF81A263),
                foregroundColor: Color(0xFFF8EDE3),
              ),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
