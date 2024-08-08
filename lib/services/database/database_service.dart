import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitty/models/user.dart';
import 'package:twitty/services/auth/auth_service.dart';

class DataBaseService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // USER PROFILE

  // save user data
  Future<void> saveUserInfoInFirebase({
    required String name,
    required String email,
  }) async {
    // get user uid
    String uid = _auth.currentUser!.uid;

    // extract username from email
    String username = email.split('@')[0];

    // Create User Profile
    UserProfile user = UserProfile(
      uid: uid,
      name: name,
      email: email,
      username: username,
      bio: '',
    );

    // Save user info in Firebase
    final userMap = user.toMap();

    await _db.collection("Users").doc(uid).set(userMap);
  }

  // get user info
  Future<UserProfile?> getUserFromFirebase(String uid) async {
    try {
      DocumentSnapshot userDoc = await _db.collection("Users").doc(uid).get();
      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> updateBio(String bio) async {
    String uid = AuthService().getCurrentUid();

    try {
      await _db.collection("Users").doc(uid).update({'bio': bio});
    } catch (e) {
      print(e);
    }
  }
}
