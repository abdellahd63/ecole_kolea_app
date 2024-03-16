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
  TextEditingController FiliereController=new TextEditingController();
  TextEditingController SectionController=new TextEditingController();
  TextEditingController GroupeController=new TextEditingController();

  String mysourceID = "";
  @override
  void initState() {
    final AuthContext authContext = context.read<AuthContext>();
    final Map<String, dynamic>? userData = authContext.state.user;
    setState(() {
      mysourceID = userData?['id'].toString() ?? "";
    });
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
  List<User> users=[
    User(id: 1, nom: "boumrar", prenom: "zineeddine", type: "enseignant"),
    User(id: 2, nom: "dekkiche", prenom: "abdallah", type: "etudiant"),
    User(id: 3, nom: "khaldi", prenom: "abdelmoumen", type: "etudiant"),
    User(id: 4, nom: "hakem", prenom: "yassine", type: "user"),
    User(id: 5, nom: "nouar", prenom: "lokmane", type: "etudiant"),
    User(id: 6, nom: "aguibi", prenom: "younes", type: "user"),
  ];
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
                InkWell(
                  onTap: () {
                    createNewRoom(FiliereController,
                        SectionController, GroupeController);
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