import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Componants/MessageCard.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/ClasseChat.dart';
import 'package:ecole_kolea_app/Model/User.dart';
import 'package:ecole_kolea_app/Model/UserAdmin.dart';
import 'package:ecole_kolea_app/controllers/Searching.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class Doleance extends StatefulWidget {
  const Doleance({super.key});

  @override
  State<Doleance> createState() => _DoleanceState();
}

class _DoleanceState extends State<Doleance> with TickerProviderStateMixin{
  TextEditingController textEditingController = TextEditingController();
  final searching = Get.put(Searching());

  String mysourceID = "";
  String mysourceType = "";
  bool loading = true;

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
      setState(() {
        Filiereitems = F_S_G_ByIDEnseignantData["filieres"] ?? [];
        Sectionitems = F_S_G_ByIDEnseignantData["sections"] ?? [];
        Groupeitems = F_S_G_ByIDEnseignantData["groupes"] ?? [];
        users = StudentsByGroupData.map<User>((item) => User.fromJson(item, 'etudiant')).toList();
        searching.DoleanceFilteredList.value = List<User>.from(users);
        loading = false;
      });
    }
    if(mysourceType == 'etudiant'){
      final StudentData = await APIs.GetStudentByID(context);
      final TeachersByGroupData = await APIs.GetTeachersByGroup(context, StudentData['groupe'].toString());
      setState(() {
        users = TeachersByGroupData.map<User>((item) => User.fromJson(item, 'enseignant')).toList();
        searching.DoleanceFilteredList.value = List<User>.from(users);
        loading = false;
      });
    }
    if(mysourceType == 'user'){
      final AllStudentsData = await APIs.GetAllStudents(context);
      setState(() {
        users = AllStudentsData.map<User>((item) => User.fromJson(item, 'etudiant')).toList();
        searching.DoleanceFilteredList.value = List<User>.from(users);
        loading = false;
      });
    }

  }

  late AnimationController ClasseIconController;
  bool ClasseisChanged = false;
  void ClasseIconClicked(){
    setState(() {
      ClasseisChanged = !ClasseisChanged;
      ClasseisChanged ? ClasseIconController.forward() : ClasseIconController.reverse();
    });
  }

  late AnimationController UserIconController;
  bool UserisChanged = false;
  void UserIconClicked(){
    setState(() {
      UserisChanged = !UserisChanged;
      UserisChanged ? UserIconController.forward() : UserIconController.reverse();
    });
  }

  late AnimationController SearchingIconController;
  bool isSearching = false;
  void Search(){
    setState(() {
      isSearching = !isSearching;
      isSearching ? SearchingIconController.forward() : SearchingIconController.reverse();
      if(!isSearching) {
        searching.DoleanceFilteredList.value = users;
        searching.DoleanceSearchingtextController.clear();
      }
    });
  }

  @override
  void initState(){
    fetchCurrentUserData();
    ClasseIconController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500)
    );
    UserIconController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500)
    );
    SearchingIconController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500)
    );

    super.initState();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Classes',
                        style: TextStyle(
                            color: MyAppColors.gray400,
                            fontSize: 12
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              iconSize: 20,
                              onPressed: ClasseIconClicked,
                              icon: AnimatedIcon(
                                icon: AnimatedIcons.menu_close,
                                color: MyAppColors.principalcolor,
                                progress: ClasseIconController,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (mysourceType != 'user' && ClasseisChanged) Expanded(
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
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                          'lib/Assets/Images/noInternet.png',
                          width: 50,
                          height: 50,
                      ),
                    ),
                  );
                } else if(snapshot.data!.isEmpty){
                  return Text('Aucune classe disponible.');
                } else {
                  List<ClasseChat> ClasseChatData = List<ClasseChat>.from(snapshot.data!.map<ClasseChat>((item) => ClasseChat.fromJson(item)));
                  if(searching.DoleanceClasseSearchingtextController.text.isEmpty) {
                    searching.DoleanceClasseFilteredList.value = ClasseChatData;
                    searching.DoleanceClasseSearchingtextController.clear();
                  }
                  return Column(
                    children: [
                      Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: SearchBar(
                          hintText: 'Search for a classe chat',
                          hintStyle: MaterialStateProperty.resolveWith((states) => TextStyle(fontSize: 12)),
                          textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
                              fontSize: 12,
                              color: MyAppColors.principalcolor
                          )),
                          controller: searching.DoleanceClasseSearchingtextController,
                          onChanged: (value){
                            if (searching.DoleanceClasseSearchingtextController.text.isEmpty) {
                              searching.DoleanceClasseSearchingtextController.clear();
                              searching.DoleanceClasseFilteredList.value = List<ClasseChat>.from(ClasseChatData);
                            }
                            if (searching.DoleanceClasseSearchingtextController.text.isNotEmpty) {
                              searching.DoleanceClasseFilteredList.value = ClasseChatData.where((classe) {
                                return classe.filiereName.toLowerCase().contains(searching.DoleanceClasseSearchingtextController.text.toLowerCase())
                                || classe.sectionName.toLowerCase().contains(searching.DoleanceClasseSearchingtextController.text.toLowerCase())
                                || classe.groupeName.toLowerCase().contains(searching.DoleanceClasseSearchingtextController.text.toLowerCase());
                              }).toList();
                            }
                          },
                          shadowColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                        ),
                      ),
                      Obx(() =>
                          Expanded(
                            child: ListView.builder(
                              itemCount: searching.DoleanceClasseFilteredList.length,
                              itemBuilder: (context, index) {
                                return MessageCard(
                                  imgpath: 'lib/Assets/Images/noprofilpic.png',
                                  title: searching.DoleanceClasseFilteredList.value[index].filiereName
                                      +" "+ searching.DoleanceClasseFilteredList.value[index].sectionName
                                      +" "+ searching.DoleanceClasseFilteredList.value[index].groupeName,
                                  type: searching.DoleanceClasseFilteredList.value[index].type,
                                  TargetID: searching.DoleanceClasseFilteredList.value[index].id.toString(),
                                );
                              },
                            ),
                          )
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          if (mysourceType == 'etudiant') Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Users',
                        style: TextStyle(
                            color: MyAppColors.gray400,
                            fontSize: 12
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              iconSize: 20,
                              onPressed: UserIconClicked,
                              icon: AnimatedIcon(
                                icon: AnimatedIcons.menu_close,
                                color: MyAppColors.principalcolor,
                                progress: UserIconController,
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )

            ),
          ),
          if (mysourceType == 'etudiant' && UserisChanged) Expanded(
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
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        'lib/Assets/Images/noInternet.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                  );
                } else if(snapshot.data!.isEmpty){
                  return Text('Aucun user disponible.');
                } else {
                  List<UserAdmin> ClasseChatData = List<UserAdmin>.from(snapshot.data!.map<UserAdmin>((item) => UserAdmin.fromJson(item, 'user')));
                  if(searching.BibliothequeSearchingtextController.text.isEmpty) {
                    searching.DoleanceUserFilteredList.value = ClasseChatData;
                    searching.DoleanceUserSearchingtextController.clear();
                  }
                  return Column(
                    children: [
                      Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: SearchBar(
                          hintText: 'Search for a user chat',
                          hintStyle: MaterialStateProperty.resolveWith((states) => TextStyle(fontSize: 12)),
                          textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
                              fontSize: 12,
                              color: MyAppColors.principalcolor
                          )),
                          controller: searching.DoleanceUserSearchingtextController,
                          onChanged: (value){
                            if (searching.DoleanceUserSearchingtextController.text.isEmpty) {
                                searching.DoleanceUserSearchingtextController.clear();
                                searching.DoleanceUserFilteredList.value = List<UserAdmin>.from(ClasseChatData);
                            }
                            if (searching.DoleanceUserSearchingtextController.text.isNotEmpty) {
                                searching.DoleanceUserFilteredList.value = ClasseChatData.where((user) {
                                  return user.role.toLowerCase().contains(searching.DoleanceUserSearchingtextController.text.toLowerCase());
                                }).toList();
                            }
                          },
                          shadowColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                        ),
                      ),
                      Obx(() => Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: searching.DoleanceUserFilteredList.length,
                          itemBuilder: (context, index) {
                            return MessageCard(
                              imgpath: 'lib/Assets/Images/noprofilpic.png',
                              title: searching.DoleanceUserFilteredList.value[index].id.toString() +" "+ searching.DoleanceUserFilteredList.value[index].role.toString(),
                              type: searching.DoleanceUserFilteredList.value[index].type.toString(),
                              TargetID: searching.DoleanceUserFilteredList.value[index].id.toString(),
                            );
                          },
                        ),
                      )),
                    ],
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              mysourceType == 'etudiant' ? 'Enseignants': 'Etudiants',
                              style: TextStyle(
                                  color: MyAppColors.gray400,
                                  fontSize: 12
                              ),
                            ),
                          ),
                          IconButton(
                              iconSize: 20,
                              onPressed: Search,
                              icon: AnimatedIcon(
                                icon: AnimatedIcons.search_ellipsis,
                                color: MyAppColors.principalcolor,
                                progress: SearchingIconController,
                              )
                          ),
                        ],
                      ),
                      AnimatedCrossFade(
                        firstChild: const Text('',
                          style: TextStyle(
                              fontSize: 0
                          ),
                        ),                        secondChild: Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 45,
                          padding: EdgeInsets.only(top: 4, bottom: 4),
                          child: SearchBar(
                            hintText: 'Search for your ${mysourceType == 'etudiant' ? 'enseignant': 'etudiant'}',
                            hintStyle: MaterialStateProperty.resolveWith((states) => TextStyle(fontSize: 12)),
                            textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
                                fontSize: 12,
                                color: MyAppColors.principalcolor
                            )),
                            controller: searching.DoleanceSearchingtextController,
                            onChanged: (value){
                              if (isSearching && searching.DoleanceSearchingtextController.text.isEmpty) {
                                setState(() {
                                  searching.DoleanceSearchingtextController.clear();
                                  searching.DoleanceFilteredList.value = List<User>.from(users);
                                });
                              }
                              if (isSearching && searching.DoleanceSearchingtextController.text.isNotEmpty) {
                                setState(() {
                                  searching.DoleanceFilteredList.value = users.where((user) {
                                    return user.nom.toLowerCase().contains(searching.DoleanceSearchingtextController.text.toLowerCase())
                                        || user.prenom.toLowerCase().contains(searching.DoleanceSearchingtextController.text.toLowerCase());
                                  }).toList();
                                });
                              }
                            },
                            shadowColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                          ),
                        ),
                        crossFadeState: isSearching
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 200),
                      )
                    ]
                ),
            ),
          ),
          if(loading)
            Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                )
            ),
          Expanded(
            child: ListView.builder(
              itemCount: searching.DoleanceFilteredList.length,
              itemBuilder: (context, index) {
                return MessageCard(
                  imgpath: 'lib/Assets/Images/noprofilpic.png',
                  title: searching.DoleanceFilteredList.value[index].nom +" "+ searching.DoleanceFilteredList.value[index].prenom, // Use filteredUsers if searching
                  type: searching.DoleanceFilteredList.value[index].type,
                  TargetID: searching.DoleanceFilteredList.value[index].id.toString(), // Use filteredUsers if searching
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}