import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blog_app/pages/user_or_admin.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset('assets/animations/welcome.json'),
      ),
      nextScreen: const UserOrAdminPage(),
      duration: 3500,
    );
  }
}
