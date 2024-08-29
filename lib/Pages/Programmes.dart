import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Semester.dart';
import 'package:ecole_kolea_app/Pages/PlanningCours.dart';
import 'package:ecole_kolea_app/Pages/PlanningExam.dart';
import 'package:ecole_kolea_app/controllers/SelectionController.dart';
import 'package:ecole_kolea_app/controllers/SharedPreferencesController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Programmes extends StatelessWidget {
  const Programmes({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    final selectionController = Get.put(SelectionController());
    final sharedPreferencesController = Get.put(SharedPreferencesController());
    String anneeUniversitaire = '';
    return Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: FutureBuilder<Map<String, dynamic>>(
        future: APIs.GetAllSemesters(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            Map<String, dynamic> semesterData = snapshot.data!;
            anneeUniversitaire = semesterData["anneeUniversitaire"]["id"].toString();
            selectionController.Semesteritems.value = semesterData["semestres"].map<Semester>((item) => Semester.fromJson(item)).toList();
            return Column(
              children: [
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      child: Text("Consulter Votre Planning",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: MyAppColors.principalcolor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30,),

                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyAppColors.gray100,
                      ),
                      child: Obx(() => DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'sélectionner le semester',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: selectionController.Semesteritems.value.map((item) =>
                              DropdownMenuItem(
                                value: item.id.toString(),
                                child: Text(item.libelle.toString()),
                              )
                          ).toList(),
                          value: selectionController.SemestertextSelection.value.isEmpty
                              ? null
                              : selectionController.SemestertextSelection.value,
                          onChanged: (value) {
                            selectionController.SemestertextSelection.value = value!;
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 200,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Rechercher un élément...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value.toString().contains(searchValue);
                            },
                          ),
                          //This to clear the search value when you close the menu
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              textEditingController.clear();
                            }
                          },
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                                  onTap: () async{
                                    if(selectionController.SemestertextSelection.value.isEmpty || anneeUniversitaire.isEmpty){
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.info(
                                          message: 'Vous devez sélectionner le semestre',
                                        ),
                                      );
                                    }else{
                                      String section = await sharedPreferencesController.getSection();
                                      Map<String, dynamic> data = await APIs.GetAllEmploiDuTemps(context, anneeUniversitaire, section, selectionController.SemestertextSelection.value);
                                      if(data != null){
                                        String name = selectionController.Semesteritems.value
                                            .where((item) => item.id.toString() == selectionController.SemestertextSelection.value)
                                            .map((item) => item.libelle.toString()).first.toString();
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlanningCours(
                                          semesterID: selectionController.SemestertextSelection.value.toString(),
                                          semester: name,
                                          emploiID: data["id"].toString()
                                        )));
                                      }else{
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          CustomSnackBar.info(
                                            message: 'aucun emploi du temps n\'est disponible',
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 170,
                                      decoration: BoxDecoration(
                                        color: MyAppColors.dimopacityvblue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(height: 70,child: Image.asset('lib/Assets/Images/plancours.png')),
                                          SizedBox(height: 10,),
                                          Text('Planning cours',
                                            style: TextStyle(
                                                color: MyAppColors.principalcolor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),

                            Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.info(
                                          message: 'Coming soon',
                                        ),
                                    );
                                    // if(selectionController.SemestertextSelection.value.isEmpty){
                                    //   showTopSnackBar(
                                    //     Overlay.of(context),
                                    //     CustomSnackBar.info(
                                    //       message: 'Vous devez sélectionner le semestre',
                                    //     ),
                                    //   );
                                    // }else {
                                    //   String name = selectionController.Semesteritems.value
                                    //       .where((item) => item.id.toString() == selectionController.SemestertextSelection.value)
                                    //       .map((item) => item.libelle.toString()).first.toString();
                                    //
                                    //   Navigator.of(context).push(
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               PlanningExam(
                                    //                 semesterID: selectionController.SemestertextSelection.value.toString(),
                                    //                 semester: name,
                                    //               )));
                                    // }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 170,


                                      decoration: BoxDecoration(
                                        color: MyAppColors.dimopacityvblue,
                                        borderRadius: BorderRadius.circular(20),

                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('lib/Assets/Images/planexams.png'),
                                          SizedBox(height: 10,),
                                          Text('Planning examens',
                                            style: TextStyle(
                                                color: MyAppColors.principalcolor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }
        },
      )
    );
  }
}