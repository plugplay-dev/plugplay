import 'package:flutter/material.dart';

void main() {
  runApp(const WTPEntertainmentApp());
}

class WTPEntertainmentApp extends StatelessWidget {
  const WTPEntertainmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WTP Entertainment',
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/images/wtp_logo.png',
          width: 220,
        ),
      ),
    );
  }
}