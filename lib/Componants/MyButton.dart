import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttontext;
  final VoidCallback? onTap;

  const MyButton({
    Key? key,
    required this.buttontext,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyAppColors.principalcolor,
        ),
        child: Center(
          child: Text(
            buttontext,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ),
    );
  }
}