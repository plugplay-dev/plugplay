import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/playlist_model.dart';
import '../models/song_model.dart';

class FirestoreService {
  FirestoreService._();

  static final FirestoreService instance = FirestoreService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get _user => FirebaseAuth.instance.currentUser;

  String get _uid => _user!.uid;

  DocumentReference<Map<String, dynamic>> get userDoc =>
      _firestore.collection('users').doc(_uid);

  Future<void> createUserDocument() async {
    await userDoc.set(
      {
        'email': _user?.email,
        'displayName': '',
        'createdAt': FieldValue.serverTimestamp(),
        'likedSongs': [],
        'playlists': [],
        'recentlyPlayed': [],
      },
      SetOptions(merge: true),
    );
  }

  // --------------------------
  // LIKED SONGS
  // --------------------------

  Future<void> saveLikedSongs(List<Song> songs) async {
    await userDoc.set(
      {
        'likedSongs': songs
            .map(
              (song) => {
                'title': song.title,
                'artist': song.artist,
                'audio': song.audio,
                'cover': song.cover,
              },
            )
            .toList(),
      },
      SetOptions(merge: true),
    );
  }

  Future<List<Song>> loadLikedSongs() async {
    final snapshot = await userDoc.get();

    if (!snapshot.exists) {
      return [];
    }

    final data = snapshot.data();

    if (data == null || data['likedSongs'] == null) {
      return [];
    }

    final likedSongs = List<Map<String, dynamic>>.from(data['likedSongs']);

    return likedSongs
        .map(
          (song) => Song(
            title: song['title'] ?? '',
            artist: song['artist'] ?? '',
            audio: song['audio'] ?? '',
            cover: song['cover'] ?? '',
          ),
        )
        .toList();
  }

  // --------------------------
  // PLAYLISTS
  // --------------------------

  Future<void> savePlaylists(List<Playlist> playlists) async {
    await userDoc.set(
      {
        'playlists': playlists
            .map(
              (playlist) => {
                'id': playlist.id,
                'name': playlist.name,
                'songs': playlist.songs
                    .map(
                      (song) => {
                        'title': song.title,
                        'artist': song.artist,
                        'audio': song.audio,
                        'cover': song.cover,
                      },
                    )
                    .toList(),
              },
            )
            .toList(),
      },
      SetOptions(merge: true),
    );
  }

  Future<List<Playlist>> loadPlaylists() async {
    final snapshot = await userDoc.get();

    if (!snapshot.exists) {
      return [];
    }

    final data = snapshot.data();

    if (data == null || data['playlists'] == null) {
      return [];
    }

    final playlistsData =
        List<Map<String, dynamic>>.from(data['playlists']);

    return playlistsData.map((playlist) {
      final songs =
          List<Map<String, dynamic>>.from(playlist['songs'] ?? []);

      return Playlist(
        id: playlist['id'] ?? '',
        name: playlist['name'] ?? '',
        songs: songs
            .map(
              (song) => Song(
                title: song['title'] ?? '',
                artist: song['artist'] ?? '',
                audio: song['audio'] ?? '',
                cover: song['cover'] ?? '',
              ),
            )
            .toList(),
      );
    }).toList();
  }
}