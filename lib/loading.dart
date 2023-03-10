import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wait 3 seconds, then navigate to home screen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset('lib/assets/splash.png'),
      ),
    );
  }
}
