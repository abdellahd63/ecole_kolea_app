import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Componants/MessageCard.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/ClasseChat.dart';
import 'package:ecole_kolea_app/Model/User.dart';
import 'package:ecole_kolea_app/Model/UserAdmin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<dynamic> Filiereitems = [];
  List<dynamic> Sectionitems = [];
  List<dynamic> Groupeitems = [];

  List<User> users= [];
  List<ClasseChat> classes= [];

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
  Future<void> fetchCurrentUserData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      mysourceID = preferences.getString("id").toString();
      mysourceType = preferences.getString("type").toString();
    });
    if(mysourceType == 'enseignant'){
      final F_S_G_ByIDEnseignantData = await APIs.GetF_S_G_ByIDEnseignant(context);
      final StudentsByGroupData = await APIs.GetStudentsByGroup(context, F_S_G_ByIDEnseignantData["groupes"]);
      final UsersData = await APIs.GetAllUsers(context);
      setState(() {
        Filiereitems = F_S_G_ByIDEnseignantData["filieres"] ?? [];
        Sectionitems = F_S_G_ByIDEnseignantData["sections"] ?? [];
        Groupeitems = F_S_G_ByIDEnseignantData["groupes"] ?? [];
        users = StudentsByGroupData.map<User>((item) => User.fromJson(item, 'etudiant')).toList();
      });
    }
    if(mysourceType == 'etudiant'){
      final StudentData = await APIs.GetStudentByID(context);
      final TeachersByGroupData = await APIs.GetTeachersByGroup(context, StudentData['groupe'].toString());
      setState(() {
        users = TeachersByGroupData.map<User>((item) => User.fromJson(item, 'enseignant')).toList();
      });
    }
    if(mysourceType == 'user'){
      final AllStudentsData = await APIs.GetAllStudents(context);
      setState(() {
        users = AllStudentsData.map<User>((item) => User.fromJson(item, 'etudiant')).toList();
      });
    }

  }
  @override
  void initState(){
    fetchCurrentUserData();
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
          SizedBox(height: 10),
          if (mysourceType != 'user') Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Classes',
                style: TextStyle(
                    color: MyAppColors.gray400,
                    fontSize: 12
                ),
              ),
            ),
          ),
          if (mysourceType != 'user') Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: APIs.GetClasseChatByIDEnseignant(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),)
                  ); // or any loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('Aucun classe chat disponible.');
                } else {
                  List<ClasseChat> ClasseChatData = List<ClasseChat>.from(snapshot.data!.map<ClasseChat>((item) => ClasseChat.fromJson(item)));
                  return ListView.builder(
                    itemCount: ClasseChatData.length,
                    itemBuilder: (context, index) {
                      return MessageCard(
                        imgpath: 'lib/Assets/Images/noprofilpic.png',
                        title: ClasseChatData[index].filiere +" "+ ClasseChatData[index].groupe,
                        type: ClasseChatData[index].type,
                        TargetID: ClasseChatData[index].id.toString(),
                      );
                    },
                  );
                }
              },
            ),
          ),
          if (mysourceType == 'etudiant') Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Users',
                style: TextStyle(
                    color: MyAppColors.gray400,
                    fontSize: 12
                ),
              ),
            ),
          ),
          if (mysourceType == 'etudiant') Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: APIs.GetAllUsers(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),)
                  ); // or any loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('Aucun user disponible.');
                } else {
                  List<UserAdmin> ClasseChatData = List<UserAdmin>.from(snapshot.data!.map<UserAdmin>((item) => UserAdmin.fromJson(item, 'user')));
                  return ListView.builder(
                    itemCount: ClasseChatData.length,
                    itemBuilder: (context, index) {
                      return MessageCard(
                        imgpath: 'lib/Assets/Images/noprofilpic.png',
                        title: ClasseChatData[index].id.toString() +" "+ ClasseChatData[index].role.toString(),
                        type: ClasseChatData[index].type.toString(),
                        TargetID: ClasseChatData[index].id.toString(),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Indeviduals',
                style: TextStyle(
                    color: MyAppColors.gray400,
                    fontSize: 12
                ),
              ),
            ),
          ),
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