import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> saveLikedSongs(List<Song> songs) async {
    await userDoc.update({
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
    });
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
}