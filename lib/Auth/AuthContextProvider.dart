import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AuthContext.dart';

class AuthContextProvider extends StatelessWidget {
  final Widget child;

  AuthContextProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthContext(),
      child: child,
    );
  }
}