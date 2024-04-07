import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Filiere.dart';
import 'package:ecole_kolea_app/Model/Groupe.dart';
import 'package:ecole_kolea_app/Model/Section.dart';
import 'package:ecole_kolea_app/controllers/GroupeChatController.js.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Presence extends StatefulWidget {
   Presence({super.key});

  @override
  State<Presence> createState() => _PresenceState();
  
}

class _PresenceState extends State<Presence> {
  TextEditingController textEditingController = TextEditingController();
  final GroupeChat = Get.put(GroupeChatController());

  String qrstr="";
  String QRCodeData= "";
  String mysourceID = "";
  String mysourceType = "";

  void fetchinitData() async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      mysourceID = preferences.getString("id").toString();
      mysourceType = preferences.getString("type").toString();
    });
    if(mysourceType == 'enseignant' && GroupeChat.Filiereitems.value.length <= 0){
      final F_S_G_ByIDEnseignantData = await APIs.GetF_S_G_ByIDEnseignant(context);
      setState(() {
        GroupeChat.Filiereitems.value = F_S_G_ByIDEnseignantData["filieres"].map<Filiere>((item) => Filiere.fromJson(item)).toList();
        GroupeChat.Sectionitems.value = F_S_G_ByIDEnseignantData["sections"].map<Section>((item) => Section.fromJson(item)).toList();
        GroupeChat.Groupeitems.value = F_S_G_ByIDEnseignantData["groupes"].map<Groupe>((item) => Groupe.fromJson(item)).toList();
      });
    }
  }
  @override
  void initState() {
    fetchinitData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (mysourceType == "enseignant")
                InkWell(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        icon:  Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: MyAppColors.principalcolor, // Border color
                              width: 2, // Border width
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.qr_code_scanner_sharp,
                            color: MyAppColors.principalcolor,
                            size: 18,
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Générer un Qr code",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: MyAppColors.principalcolor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Filiere : ",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Obx(() =>
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        'sélectionner la filiere',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: GroupeChat.Filiereitems.value.map((item) =>
                                          DropdownMenuItem(
                                            value: item.id.toString(),
                                            child: Text(item.libelle.toString()),
                                          )
                                      ).toList(),
                                      value: GroupeChat.FilieretextSelection.value.isEmpty
                                          ? null
                                          : GroupeChat.FilieretextSelection.value,
                                      onChanged: (value) {
                                        setState(() {
                                          GroupeChat.FilieretextSelection.value = value!;
                                          GroupeChat.SectiontextSelection.value = '';
                                          GroupeChat.GroupetextSelection.value = '';
                                        });
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
                                  ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Section : ",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Obx(() =>
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        'sélectionner la section',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: GroupeChat.Sectionitems.value
                                          .where((item) => item.filiere.toString() == GroupeChat.FilieretextSelection.value)
                                          .map((item) =>
                                          DropdownMenuItem(
                                            value: item.id.toString(),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Section '+item.libelle.toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                      ).toList(),
                                      value: GroupeChat.SectiontextSelection.value.isEmpty
                                          ? null
                                          : GroupeChat.SectiontextSelection.value,
                                      onChanged: (value) {
                                        setState(() {
                                          GroupeChat.SectiontextSelection.value = value!;
                                          GroupeChat.GroupetextSelection.value = '';
                                        });
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
                                  ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Groupe : ",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Obx(() =>
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        'sélectionner la groupe',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: GroupeChat.Groupeitems.value
                                          .where((item) => item.section.toString() == GroupeChat.SectiontextSelection.value)
                                          .map((item) =>
                                          DropdownMenuItem(
                                            value: item.id.toString(),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Groupe '+item.libelle.toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                      ).toList(),
                                      value: GroupeChat.GroupetextSelection.value.isEmpty
                                          ? null
                                          : GroupeChat.GroupetextSelection.value,
                                      onChanged: (value) {
                                        setState(() {
                                          GroupeChat.GroupetextSelection.value = value!;
                                        });
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
                                  ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Heure : ",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Obx(() =>
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        'sélectionner l\'heure',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: GroupeChat.Timeitems.value
                                          .map((item) =>
                                          DropdownMenuItem(
                                            value: item,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                      ).toList(),
                                      value: GroupeChat.TimetextSelection.value.isEmpty
                                          ? null
                                          : GroupeChat.TimetextSelection.value,
                                      onChanged: (value) {
                                        setState(() {
                                          GroupeChat.TimetextSelection.value = value!;
                                        });
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
                                  ),
                              ),
                              SizedBox(height: 16),
                              Padding(
                                padding: EdgeInsets.only(top:20.0 , bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: MyAppColors.principalcolor, width: 1.7,
                                              ),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          margin: EdgeInsets.only(right: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                          child: Center(
                                            child: Text(
                                              'Annuler',
                                              style: TextStyle(
                                                color: MyAppColors.principalcolor,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: (){
                                          Navigator.of(context).pop();
                                          GroupeChat.ClearAll();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: MyAppColors.principalcolor,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: MyAppColors.principalcolor, width: 1.7,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Confirmer',
                                              style: TextStyle(
                                                color: MyAppColors.whitecolor,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () async {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Container(
                                                  width: MediaQuery.of(context).size.width * 0.9,
                                                  height: MediaQuery.of(context).size.height * 0.6,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          'Veuillez être patient jusqu\'à la fin de ce processus...',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        SizedBox(height: 16),
                                                        CircularProgressIndicator(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                          QRCodeData = await APIs.GetCreneau(context,
                                              GroupeChat.TimetextSelection.value.toString(),
                                              GroupeChat.GroupetextSelection.value.toString()
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyAppColors.principalcolor,
                      border: Border.all(
                        color: MyAppColors.principalcolor, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.refresh_outlined,
                      color: MyAppColors.whitecolor,
                      size: 18,
                    ),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: Text("Scanner ce QR code pour justifier votre présence", 
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical:10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("Appuyer pour scanner", 
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical:25.0),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(color: MyAppColors.dimopacityvblue, borderRadius: BorderRadius.circular(20)),
                    child: Icon(Icons.qr_code_scanner, size: 250,)),
                    onTap: (){
                      scanQr();
                    },
                ),
              ),

               Row(
                children: [
                  Expanded(
                    child: Text("Merci !", 
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

            ]),
        ),
      ),
    );
  }

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'Annuler', true, ScanMode.QR)
          .then((value) {
        setState(() {
          qrstr = value;// Invoke the callback function
        });
      });
    } catch (e) {
      qrstr = "essayer à nouveau";
    }
  }
}

