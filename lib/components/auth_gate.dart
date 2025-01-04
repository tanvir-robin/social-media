import 'package:appifylab_task/controllers/auth_controller.dart';
import 'package:appifylab_task/views/Auth/login_screen.dart';
import 'package:appifylab_task/views/Feed/feed.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _isUserLoggedIn() async {
    final authController = AuthController.instance;
    return await authController.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong! ${snapshot.error}'));
        } else if (snapshot.data == true) {
          return CommunityFeed();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
