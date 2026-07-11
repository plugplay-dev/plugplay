import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090909),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.amber,
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 50,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "PlugPlay User",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "user@plugplay.com",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

          ],
        ),
      ),
    );
  }
}