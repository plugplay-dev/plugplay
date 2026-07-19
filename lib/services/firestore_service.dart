import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}