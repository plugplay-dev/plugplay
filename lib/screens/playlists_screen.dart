import 'package:flutter/material.dart';

import '../services/music_service.dart';

class PlaylistsScreen extends StatefulWidget {
  const PlaylistsScreen({super.key});

  @override
  State<PlaylistsScreen> createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  final MusicService music = MusicService.instance;

  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090909),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("📂 Playlists"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text("Create Playlist"),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Playlist name",
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final name = controller.text.trim();

                      if (name.isEmpty) return;

                      try {
                        await music.createPlaylist(name);

                        if (!mounted) return;

                        controller.clear();

                        Navigator.pop(context);

                        setState(() {});
                      } catch (e) {
                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    child: const Text("Create"),
                  ),
                ],
              );
            },
          );
        },
      ),
      body: music.playlists.isEmpty
          ? const Center(
              child: Text(
                "No playlists yet",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              itemCount: music.playlists.length,
              itemBuilder: (context, index) {
                final playlist = music.playlists[index];

                return Card(
                  color: Colors.white10,
                  margin: const EdgeInsets.all(12),
                  child: ListTile(
                    leading: const Icon(
                      Icons.queue_music,
                      color: Colors.amber,
                    ),
                    title: Text(
                      playlist.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${playlist.songs.length} song(s)",
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}