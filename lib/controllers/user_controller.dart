import 'package:flutter/material.dart';

import '../models/user.dart';

enum UserRole { jobSeeker, admin, employer }

class UserController with ChangeNotifier {
  User? user;

  get isLoggedIn => user != null;

  UserRole get role => isLoggedIn ? user!.role : UserRole.jobSeeker;

  void setUser(User? u) {
    user = u;
    notifyListeners();
  }
}
