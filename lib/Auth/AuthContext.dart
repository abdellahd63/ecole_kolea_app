import 'package:flutter/material.dart';

class AuthState {
  final Map<String, dynamic>? user;

  AuthState({this.user});
}

class AuthContext extends ChangeNotifier {
  AuthState _state = AuthState();

  AuthState get state => _state;

  void login(Map<String, dynamic> user) {
    _state = AuthState(user: user);
    notifyListeners();
  }

  void logout() {
    _state = AuthState();
    notifyListeners();
  }
}
