import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Auth/AuthContext.dart';
import 'package:ecole_kolea_app/Componants/MessageCard.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Doleance extends StatefulWidget {
  const Doleance({super.key});

  @override
  State<Doleance> createState() => _DoleanceState();
}

class _DoleanceState extends State<Doleance> {
  TextEditingController textEditingController = TextEditingController();

  String mysourceID = "";
  String mysourceType = "";
  String? selectedFiliere;
  String? selectedSection;
  String? selectedGroupe;
  Map<String, dynamic> itemsData = {};
  List<dynamic> Filiereitems = [];
  List<dynamic> Sectionitems = [];
  List<dynamic> Groupeitems = [];

  List<User> users=[];
  @override
  void initState() {
    final AuthContext authContext = context.read<AuthContext>();
    final Map<String, dynamic>? userData = authContext.state.user;
    _fetchFilieres_Sections_Groupes();
    setState(() {
      mysourceID = userData?['id'].toString() ?? "";
      mysourceType = userData?['type'].toString() ?? "";
      users = [
        User(id: 1, nom: "boumrar", prenom: "zineeddine", type: "enseignant"),
        User(id: 2, nom: "dekkiche", prenom: "abdallah", type: "etudiant"),
        User(id: 3, nom: "khaldi", prenom: "abdelmoumen", type: "etudiant"),
        User(id: 4, nom: "hakem", prenom: "yassine", type: "user"),
        User(id: 5, nom: "nouar", prenom: "lokmane", type: "etudiant"),
        User(id: 6, nom: "aguibi", prenom: "younes", type: "user"),
      ];
    });
  }
  Future<void> _fetchFilieres_Sections_Groupes() async {
    final data = await APIs.GetF_S_G_ByIDEnseignant(context);
    setState(() {
      Filiereitems = data["filieres"] ?? [];
      Sectionitems = data["sections"] ?? [];
      Groupeitems = data["groupes"] ?? [];
    });
    print(data["filieres"]);
    print(data["sections"]);
    print(data["groupes"]);
  }
  Future<void> createNewRoom(FiliereController, SectionController, GroupeController) async {
    Map<String, dynamic> room = await APIs.CreateNewRoom(
        context,
        FiliereController,
        SectionController,
        GroupeController,
        mysourceID
    );
    if(room.length > 0){
      setState(() {
        users.add(User(id: 38, nom: "informatique", prenom: "G1", section: "1", type: "classe"));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10), // Adjust the margin as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Tous mes messages'),
                ),
                if (mysourceType == "enseignant")
                  InkWell(
                  onTap: () {
                    showDialog(
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
                            Icons.group_add,
                            color: MyAppColors.principalcolor,
                            size: 18,
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Groupe de discussion",
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
                                  items: Filiereitems.map((item) =>
                                      DropdownMenuItem(
                                        value: item['id'].toString(),
                                        child: Text(item['libelle'].toString()),
                                      )
                                  ).toList(),
                                  value: selectedFiliere,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedFiliere = value;
                                    });
                                    print(selectedFiliere);
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
                              SizedBox(height: 8),
                              Text(
                                "Section : ",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
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
                                  items: Sectionitems.map((item) =>
                                      DropdownMenuItem(
                                        value: item['id'].toString(),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Section '+item['libelle'].toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ).toList(),
                                  value: selectedSection,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSection = value;
                                    });
                                    print(selectedSection);
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
                              SizedBox(height: 8),
                              Text(
                                "Groupe : ",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
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
                                  items: Groupeitems.map((item) =>
                                      DropdownMenuItem(
                                        value: item['id'].toString(),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Groupe '+item['libelle'].toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ).toList(),
                                  value: selectedGroupe,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGroupe = value;
                                    });
                                    print(selectedGroupe);
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
                                          margin: EdgeInsets.only(right: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: MyAppColors.principalcolor, width: 1.7,
                                              ),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
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
                                          createNewRoom(
                                              selectedFiliere,
                                              selectedSection,
                                              selectedGroupe
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
                      color: MyAppColors.whitecolor,
                      border: Border.all(
                        color: MyAppColors.principalcolor, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.group_add,
                      color: MyAppColors.principalcolor,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return MessageCard(
                  imgpath: 'lib/Assets/Images/noprofilpic.png',
                  title: users[index].nom +" "+ users[index].prenom,
                  type: users[index].type,
                  TargetID: users[index].id.toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}