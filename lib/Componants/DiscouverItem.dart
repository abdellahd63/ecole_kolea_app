import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';

class DiscoverItem extends StatelessWidget {
  var imgpath;
  String title;
  DiscoverItem({super.key,required this.imgpath,required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
                              
              ),
            child: Image.asset(imgpath),
            ),
    
            Text(title,
              style: TextStyle(
                color: MyAppColors.principalcolor,
                fontWeight: FontWeight.w600,
                ),
              ),
        ],
      ),
    );
  }
}