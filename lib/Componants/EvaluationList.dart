import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/NoteModule.dart';
import 'package:flutter/material.dart';

class EvaluationList extends StatelessWidget {
  const EvaluationList({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: APIs.GetAllNoteModuleByIDAffichage(context, id),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data available.'));
            } else {
              List<NoteModule> NoteModuleData = List<NoteModule>.from(snapshot.data!.map<NoteModule>((item) => NoteModule.fromJson(item)));
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal:  20),
                child: Column(
                  children: [
                    /*if(NoteModuleData.length > 0)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox( height: 10,),
                        Text("Moyenne Generale : ",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: MyAppColors.black,
                            fontSize: 16,
                          ),
                        ),

                        SizedBox( width: 10,),

                        Text("00.00",
                          textAlign: TextAlign.left,
                          softWrap: true,

                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                              fontSize: 32,
                              height: 1
                          ),
                        ),
                        Text(" /20",
                          textAlign: TextAlign.left,
                          softWrap: true,

                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                            fontSize: 16,

                          ),
                        ),
                      ],
                    ),
                    if(NoteModuleData.length > 0)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox( height: 10,),
                        Text("Montion : ",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: MyAppColors.black,
                            fontSize: 16,
                          ),
                        ),


                        Text("...",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: MyAppColors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),*/
                    if(NoteModuleData.length > 0)
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: NoteModuleData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:6.0),
                            child: Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyAppColors.dimopacityvblue,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(NoteModuleData[index].NomModule ?? '.',
                                        textAlign: TextAlign.left,
                                        softWrap: true,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: MyAppColors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(NoteModuleData[index].note.toString() ?? '.',
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: NoteModuleData[index].note >= 10 ? Colors.green : Colors.red,
                                              fontSize: 26,
                                            ),
                                          ),

                                          Text("/20")
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Center(
                                    child: Text(
                                              NoteModuleData[index].remarque,
                                              style: TextStyle(
                                                color: NoteModuleData[index].remarque == 'bad' || NoteModuleData[index].remarque == 'very bad'
                                                    ? Colors.red
                                                    : Colors.green
                                              ),
                                          )
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Credit : ', style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                            Text('30', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey),),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Coefficient : ', style: TextStyle(
                                                color: Colors.grey
                                            ),),
                                            Text('3', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('TP : ',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                            Text('14', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                            Text('/20',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('TP : ',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                            Text('14', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                            Text('/20',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Examen : ',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                        Text('14', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                        Text('/20',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    if(NoteModuleData.length <= 0)
                      Text('Pas encore'),
                  ],
                ),
              );
            }
          }
    );
  }
}