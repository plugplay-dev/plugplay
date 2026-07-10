import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
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
                "🔥 Trending",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 190,

                child: ListView(
                  scrollDirection: Axis.horizontal,

                  children: [

                    albumCard(
                      "Top Hits",
                      Icons.album,
                    ),

                    albumCard(
                      "Afrobeats",
                      Icons.music_note,
                    ),

                    albumCard(
                      "Hip Hop",
                      Icons.headphones,
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "❤️ Made For You",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              playlistTile(
                "Daily Mix",
                "20 Songs",
              ),

              playlistTile(
                "Workout",
                "15 Songs",
              ),

              playlistTile(
                "Chill Vibes",
                "32 Songs",
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

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,

                children: [

                  artistAvatar("A"),

                  artistAvatar("B"),

                  artistAvatar("C"),

                  artistAvatar("D"),

                ],
              ),

              const SizedBox(height: 40),

            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,

        selectedItemColor: Colors.amber,

        unselectedItemColor: Colors.grey,

        type: BottomNavigationBarType.fixed,

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

  Widget albumCard(String title, IconData icon) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            color: Colors.amber,
            size: 70,
          ),

          const SizedBox(height: 15),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }

  Widget playlistTile(
      String title,
      String subtitle,
      ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: Container(
        width: 60,
        height: 60,

        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius:
              BorderRadius.circular(15),
        ),

        child: const Icon(
          Icons.music_note,
          color: Colors.black,
        ),
      ),

      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),

      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.white54,
        ),
      ),

      trailing: const Icon(
        Icons.play_circle_fill,
        color: Colors.amber,
      ),
    );
  }

  Widget artistAvatar(String letter) {
    return Column(
      children: [

        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.amber,

          child: Text(
            letter,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "Artist",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),

      ],
    );
  }
}