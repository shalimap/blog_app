import 'package:hive/hive.dart';

import '../models/user/user_model.dart';

class HiveDatabase {
  static const String userBoxName = 'userBox';
  static const String currentUserKey = 'currentUserId';
  static const String userLoginBoxName = 'userLoginBox';
  static const String isUserLoggedInKey = 'isUserLoggedIn';

  Future<void> addUser(User user) async {
    var box = await Hive.openBox<User>(userBoxName);
    await box.put(user.id, user);
  }

  Future<User?> getUser(String id) async {
    var box = await Hive.openBox<User>(userBoxName);
    return box.get(id);
  }

  Future<List<User>> getAllUsers() async {
    var box = await Hive.openBox<User>(userBoxName);
    return box.values.toList();
  }

  Future<void> deleteUser(String id) async {
    var box = await Hive.openBox<User>(userBoxName);
    await box.delete(id);
  }

  Future<void> clearUsers() async {
    var box = await Hive.openBox<User>(userBoxName);
    await box.clear();
  }

  // Get the current user
  Future<User?> getCurrentUser() async {
    var box = await Hive.openBox<String>('appPreferences');
    final currentUserId = box.get(currentUserKey);
    if (currentUserId != null) {
      var userBox = await Hive.openBox<User>(userBoxName);
      return userBox.get(currentUserId);
    }
    return null;
  }

  // Set the current user
  Future<void> setCurrentUser(String userId) async {
    var box = await Hive.openBox<String>('appPreferences');
    await box.put(currentUserKey, userId);
  }

  // Log out the current user
  Future<void> logoutUser() async {
    var box = await Hive.openBox<String>('appPreferences');
    await box.delete(currentUserKey);
  }

  // Set user login status
  Future<void> setUserLoginStatus(bool isLoggedIn) async {
    var box = await Hive.openBox(userLoginBoxName);
    await box.put(isUserLoggedInKey, isLoggedIn);
  }

  // Get user login status
  Future<bool> getUserLoginStatus() async {
    var box = await Hive.openBox(userLoginBoxName);
    return box.get(isUserLoggedInKey, defaultValue: false);
  }

  // Ban a user
  Future<void> banUser(String id) async {
    var box = await Hive.openBox<User>(userBoxName);
    User? user = box.get(id);
    if (user != null) {
      user.isBanned = true;
      await user.save();
    }
  }

  // Unban a user
  Future<void> unbanUser(String id) async {
    var box = await Hive.openBox<User>(userBoxName);
    User? user = box.get(id);
    if (user != null) {
      user.isBanned = false;
      await user.save();
    }
  }
}
