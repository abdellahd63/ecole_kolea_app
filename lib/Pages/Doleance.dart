import 'package:ecole_kolea_app/Componants/MessageCard.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/User.dart';
import 'package:flutter/material.dart';

class Doleance extends StatelessWidget {
  const Doleance({super.key});

  @override
  Widget build(BuildContext context) {
    List<User> users=[
      User(id: 1, nom: "boumrar", prenom: "zineeddine", type: "enseignant"),
      User(id: 2, nom: "dekkiche", prenom: "abdallah", type: "etudiant"),
      User(id: 3, nom: "khaldi", prenom: "abdelmoumen", type: "etudiant"),
      User(id: 4, nom: "hakem", prenom: "yassine", type: "user"),
      User(id: 5, nom: "nouar", prenom: "lokmane", type: "enseignant"),
      User(id: 6, nom: "aguibi", prenom: "younes", type: "user"),
    ];
    return Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Tous mes messages'),
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