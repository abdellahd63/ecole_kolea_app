import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Searching extends GetxController {
  //Bibliotheque
  TextEditingController BibliothequeSearchingtextController = TextEditingController();
  var BibliothequeFilteredList = [].obs;

  //Categorie
  TextEditingController CategorieSearchingtextController = TextEditingController();
  var CategorieFilteredList = [].obs;

  //Document
  TextEditingController DocumentSearchingtextController = TextEditingController();
  var DocumentFilteredList = [].obs;

  //Doleance
  TextEditingController DoleanceSearchingtextController = TextEditingController();
  var DoleanceFilteredList = [].obs;

  //DoleanceClasse
  TextEditingController DoleanceClasseSearchingtextController = TextEditingController();
  var DoleanceClasseFilteredList = [].obs;

  //DoleanceUser
  TextEditingController DoleanceUserSearchingtextController = TextEditingController();
  var DoleanceUserFilteredList = [].obs;

}