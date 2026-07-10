import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const PlugPlayApp());
}

class PlugPlayApp extends StatelessWidget {
  const PlugPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlugPlay',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const SplashScreen(),
    );
  }
}