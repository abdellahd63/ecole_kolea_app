import 'package:ecole_kolea_app/Componants/MessageCard.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/User.dart';
import 'package:flutter/material.dart';

class Doleance extends StatelessWidget {
  const Doleance({super.key});

  @override
  Widget build(BuildContext context) {
    List<User> users=[
      User(id: 1, nom: "zino1", prenom: "boumrar", type: "administrator"),
      User(id: 2, nom: "zino2", prenom: "aguibi", type: "student"),
      User(id: 3, nom: "zino3", prenom: "hakem", type: "director"),
      User(id: 4, nom: "zino4", prenom: "dekkiche", type: "teacher"),
      User(id: 5, nom: "zino5", prenom: "khaldi", type: "teacher"),
      User(id: 6, nom: "zino6", prenom: "nouar", type: "administrator"),
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
                  subTitle: users[index].type,
                  UserID: users[index].id.toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}