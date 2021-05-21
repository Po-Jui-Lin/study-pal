import 'package:flutter/foundation.dart';

class UserDataProvider with ChangeNotifier {
  List usersLiked = [];
  List likedBy = [];

  void addUsersLiked(String uid) {
    usersLiked.add(uid);
    notifyListeners();
  }
}
