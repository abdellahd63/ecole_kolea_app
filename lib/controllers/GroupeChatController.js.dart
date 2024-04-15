import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GroupeChatController extends GetxController {
  //Filiere
  var FilieretextSelection = ''.obs;
  var Filiereitems = [].obs;

  //Section
  var SectiontextSelection = ''.obs;
  var Sectionitems = [].obs;

  //Groupe
  var GroupetextSelection = ''.obs;
  var Groupeitems = [].obs;

  //Times
  var TimetextSelection = ''.obs;
  var Timeitems = ['08:00:00','09:35:00','11:10:00','12:45:00','14:20:00', '15:55:00'].obs;

  void ClearAll(){
    FilieretextSelection.value = '';
    SectiontextSelection.value = '';
    GroupetextSelection.value = '';
    TimetextSelection.value = '';
  }
  void ClearAllItems(){
    Filiereitems.value.clear();
    Sectionitems.value.clear();
    Groupeitems.value.clear();
  }

}