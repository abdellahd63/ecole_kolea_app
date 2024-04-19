import 'dart:async';

import 'package:date_time/date_time.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Filiere.dart';
import 'package:ecole_kolea_app/Model/Groupe.dart';
import 'package:ecole_kolea_app/Model/Section.dart';
import 'package:ecole_kolea_app/controllers/GroupeChatController.js.dart';
import 'package:ecole_kolea_app/controllers/QRcodeController.dart';
import 'package:ecole_kolea_app/util/Encryption.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Presence extends StatefulWidget {
   Presence({super.key});

  @override
  State<Presence> createState() => _PresenceState();
  
}

class _PresenceState extends State<Presence> {
  TextEditingController textEditingController = TextEditingController();
  final GroupeChat = Get.put(GroupeChatController());
  final QRCODEController = Get.put(QRcodeController());

  String qrstr="";
  String QRCodeData= "";
  String mysourceID = "";
  String mysourceType = "";
  int timeleft = 0;
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

  void Timerleft(){
    Timer.periodic(Duration(seconds: 20), (timer) {
      if(QRCODEController.QrCodeData.value.isEmpty){
        timer.cancel();
      }else{
        setState(() {
          timeleft++;
        });
      }
    });
  }

  @override
  void initState() {
    fetchinitData();
  }

  @override
  Widget build(BuildContext context) {
    return mysourceType == "enseignant" ? Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10), // Adjust the margin as needed
                      child: Obx(() =>Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Créer un code QR'),
                          ),
                          QRCODEController.QrCodeData.value.isEmpty
                              ? InkWell(
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
                                          Icons.qr_code_2_sharp,
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
                                                      'sélectionner le groupe',
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
                                                        QRCODEController.QrCodeData.value = await APIs.GetCreneau(context,
                                                            GroupeChat.TimetextSelection.value.toString(),
                                                            GroupeChat.GroupetextSelection.value.toString()
                                                        );
                                                        if(QRCODEController.QrCodeData.value.isNotEmpty){
                                                          QRCODEController.QrOpacity.value = 1;
                                                        }
                                                        GroupeChat.ClearAll();
                                                        Timerleft();
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
                                    Icons.qr_code,
                                    color: MyAppColors.whitecolor,
                                    size: 18,
                                  ),
                                ),
                              )
                              : InkWell(
                                onTap: (){
                                  QRCODEController.Clear();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyAppColors.red,
                                    border: Border.all(
                                      color: MyAppColors.red, // Border color
                                      width: 0.5, // Border width
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.cancel,
                                    color: MyAppColors.whitecolor,
                                    size: 34,
                                  ),
                                ),
                              ),
                        ],
                      )),
                    ),
                    SizedBox(height: 100,),
                    Obx(() =>
                        Column(
                          children: [
                            if(QRCODEController.QrCodeData.value.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text('Vous pouvez scanner maintenant',
                                  style: TextStyle(
                                      color: Colors.green
                                  ),
                                ),
                              ),
                            Opacity(
                              opacity: QRCODEController.QrOpacity.value,
                              child: QrImageView(
                                data: Encryption.encryptAES(QRCODEController.QrCodeData.value.isNotEmpty ? '${DateTime.now()}#${QRCODEController.QrCodeData.value}': ''),
                                version: QrVersions.auto,
                                size: 300.0,
                              ),
                            ),
                          ],
                        ),
                    )
                  ],
                ),
            ]),
        ),
      ),
    ) : Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              children: [
                  Column(
                    children: [
                      Text("Scanner ce QR code pour justifier votre présence",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: MyAppColors.principalcolor,
                          fontSize: 20,
                        ),
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
          .then((value) async {
            setState(() {
              qrstr = Encryption.decryptAES(value);
            });
            if (qrstr.isNotEmpty) {
              var data = qrstr.split('#');
              if(data.length == 2){
                // Parse the date from the qrstr
                DateTime qrDate = DateTime.parse(data[0]);

                // Get the current date without the time
                DateTime currentDate = DateTime.now();

                // Calculate the difference in seconds
                Duration difference = qrDate.difference(currentDate);
                print(qrDate);
                print(currentDate);
                print(difference.inSeconds > -1 &&
                    difference.inSeconds <= 20);
                // Compare the date parts
                if ((difference.inSeconds > -1 &&
                    difference.inSeconds <= 20) &&
                    data[1].toString().isNotEmpty
                ) {
                  await APIs.PostPresence(context, data[1]);
                }else{
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message: 'QR Code non valide',
                    ),
                  );
                }
              }else{
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(
                    message: 'QR Code non valide',
                  ),
                );
              }
            }
          }
      );
    } catch (e) {
      qrstr = "essayer à nouveau";
    }
  }
}

