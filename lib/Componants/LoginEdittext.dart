import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';

class LoginEdittext extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final icon;
  final visiblicon;
  

  LoginEdittext({
    Key? key,
    required this.hint,
    required this.isPassword,
    required this.controller,
    required this.icon,
    required this.visiblicon,
    this.onChanged,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: TextField(
        
        obscureText: isPassword,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyAppColors.principalcolor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          fillColor: Colors.grey[300],
          filled: true,
          hintText: hint,
          prefixIcon: Icon(icon),
          suffixIcon:  Icon(visiblicon),
          
        ),
        controller: controller,
        onChanged: onChanged,
         // Pass the onChanged callback to the TextField
      ),
    );
  }
}