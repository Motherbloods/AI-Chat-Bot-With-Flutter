import 'package:fe/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF81A263), Color(0xFFF8EDE3)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chat, size: 80, color: Color(0xFF81A263)),
                      SizedBox(height: 24),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF81A263)),
                      ),
                      SizedBox(height: 24),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon:
                              Icon(Icons.person, color: Color(0xFF81A263)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xFF81A263)),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon:
                              Icon(Icons.lock, color: Color(0xFF81A263)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xFF81A263)),
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          await _authController.login(
                            _usernameController.text,
                            _passwordController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF81A263),
                          foregroundColor: Color(0xFFF8EDE3),
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Login', style: TextStyle(fontSize: 18)),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Get.to(() => RegisterScreen()),
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFF81A263),
                        ),
                        child: Text('Don\'t have an account? Register'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
