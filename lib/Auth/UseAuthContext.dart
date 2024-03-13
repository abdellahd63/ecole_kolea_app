import 'package:ecole_kolea_app/Auth/AuthContext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AuthContext useAuthContext(BuildContext context) {
  return Provider.of<AuthContext>(context, listen: false);
}