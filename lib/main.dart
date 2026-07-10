import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const WTPEntertainment());
}

class WTPEntertainment extends StatelessWidget {
  const WTPEntertainment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WTP Entertainment',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const SplashScreen(),
    );
  }
}