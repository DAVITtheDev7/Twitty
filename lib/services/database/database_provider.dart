import 'package:flutter/material.dart';
import 'package:twitty/models/user.dart';
import 'package:twitty/services/database/database_service.dart';

class DataBaseProvider extends ChangeNotifier {
  // Services
  final _db = DataBaseService();

  // User Profile
  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFirebase(uid);

  // Update bio
  Future<void> updateBio(String bio) => _db.updateBio(bio);
}
