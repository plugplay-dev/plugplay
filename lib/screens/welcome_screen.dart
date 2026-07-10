import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(
                'assets/images/wtp_logo.png',
                width: 180,
              ),

              const SizedBox(height: 30),

              const Text(
                "PlugPlay",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Unlimited Music.\nUnlimited Vibes.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}