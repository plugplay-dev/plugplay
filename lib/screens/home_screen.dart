import 'package:flutter/material.dart';

import '../models/song_model.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090909),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "PlugPlay",
          style: TextStyle(
            color: Colors.amber,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Good Evening 👋",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Discover your next favorite song",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white10,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.amber,
                ),
                hintText: "Search music...",
                hintStyle: const TextStyle(
                  color: Colors.white54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "🔥 My Songs",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: demoSongs.length,
              itemBuilder: (context, index) {
                final song = demoSongs[index];

                return Card(
                  color: Colors.white10,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/${song.cover}",
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      song.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      song.artist,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.play_circle_fill,
                      color: Colors.amber,
                      size: 35,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlayerScreen(song: song),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            const Text(
              "🎤 Top Artists",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                  child: Text(
                    "A",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                  child: Text(
                    "B",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                  child: Text(
                    "C",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                  child: Text(
                    "D",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}