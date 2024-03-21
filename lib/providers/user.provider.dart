import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String _username = '';
  String _password = '';
  String _email = '';
  String _profilePicture = '';

  String get username => _username;
  String get password => _password;
  String get email => _email;
  String get profilePicture => _profilePicture;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set profilePicture(String value) {
    _profilePicture = value;
    notifyListeners();
  }

  void clear() {
    _username = '';
    _password = '';
    _email = '';
    _profilePicture = '';
    notifyListeners();
  }
}
