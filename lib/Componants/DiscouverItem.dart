import 'package:ecole_kolea_app/Constant.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';

class DiscoverItem extends StatelessWidget {
  var imgpath;
  String title;
  String description;
  DiscoverItem({super.key,required this.imgpath,required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: Container(
        width: 330,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 3.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.zero,
              width: 330,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0),),
                 image: DecorationImage(image: AssetImage(imgpath), fit: BoxFit.cover, )               
                ),
              
              ),
            
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Text(title,
                  style: TextStyle(
                    color: MyAppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    ),
                  ),
              ),

               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Text(description,
                softWrap: true,
                textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: MyAppColors.gray400,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    
                    ),
                  ),
              ),
          ],
        ),
      ),
    );
  }
}