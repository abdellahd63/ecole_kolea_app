import 'package:get/get.dart';

class SelectionController extends GetxController {
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
  var Timeitems = [].obs;

  //Semesters
  var SemestertextSelection = ''.obs;
  var SemesterNametextSelection = ''.obs;
  var Semesteritems = [].obs;

  void ClearAll(){
    FilieretextSelection.value = '';
    SectiontextSelection.value = '';
    GroupetextSelection.value = '';
    SemestertextSelection.value = '';
    SemesterNametextSelection.value = '';
    TimetextSelection.value = '';
  }
  void ClearAllItems(){
    Filiereitems.value.clear();
    Sectionitems.value.clear();
    Groupeitems.value.clear();
    Timeitems.value.clear();
    Semesteritems.value.clear();
  }

}