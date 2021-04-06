
import 'package:flutter/cupertino.dart';
import 'package:sykebe_clone/models/user.dart';
import 'package:sykebe_clone/resourses/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User _user;
  AuthMethods _authMethods = AuthMethods();

  User get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

}