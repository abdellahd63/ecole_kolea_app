import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Creneau.dart';
import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';

class PlanningCours extends StatelessWidget {
  PlanningCours({super.key, required String this.semesterID, required String this.semester, required this.emploiID});
  String semester;
  String semesterID;
  String emploiID;
  List<TimePlannerTask> tasks = [
    TimePlannerTask(
      color: MyAppColors.principalcolor,
      dateTime: TimePlannerDateTime(day: 0, hour: 8, minutes: 00),
      minutesDuration: 90,
      daysDuration: 1,
      onTap: () {},
      child: Text(
        'Algorithme \n 8:00',
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),

    TimePlannerTask(
      color: MyAppColors.principalcolor,
      dateTime: TimePlannerDateTime(day: 0, hour: 10, minutes: 00),
      minutesDuration: 90,
      daysDuration: 1,
      onTap: () {},
      child: Text(
        'Analyse \n 10:00',
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),

    TimePlannerTask(
      color: MyAppColors.principalcolor,
      dateTime: TimePlannerDateTime(day: 1, hour: 8, minutes: 00),
      minutesDuration: 90,
      daysDuration: 1,
      onTap: () {},
      child: Text(
        'Algebre \n 8:00',
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),


    TimePlannerTask(
      color: MyAppColors.principalcolor,
      dateTime: TimePlannerDateTime(day: 1, hour: 14, minutes: 00),
      minutesDuration: 90,
      daysDuration: 1,
      onTap: () {},
      child: Text(
        'Strecture machine \n 8:00',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),


    TimePlannerTask(
      color: MyAppColors.principalcolor,
      dateTime: TimePlannerDateTime(day: 2, hour: 10, minutes: 00),
      minutesDuration: 90,
      daysDuration: 1,
      onTap: () {},
      child: Text(
        'Algorithme TD \n 10:00',
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),

    TimePlannerTask(
      color: MyAppColors.principalcolor,
      dateTime: TimePlannerDateTime(day: 3, hour: 12, minutes: 00),
      minutesDuration: 90,
      daysDuration: 1,
      onTap: () {},
      child: Text(
        'Algebre TD \n 8:00',
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),


    TimePlannerTask(
      color: MyAppColors.principalcolor,
      dateTime: TimePlannerDateTime(day: 3, hour: 14, minutes: 00),
      minutesDuration: 90,
      daysDuration: 1,
      onTap: () {},
      child: Text(
        'Strecture machine TP \n 8:00',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),

    TimePlannerTask(
      color: MyAppColors.principalcolor,
      dateTime: TimePlannerDateTime(day: 4, hour: 8, minutes: 00),
      minutesDuration: 90,
      daysDuration: 1,
      onTap: () {},
      child: Text(
        'Algorithme TP \n 8:00',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),

    TimePlannerTask(
      color: MyAppColors.principalcolor,
      dateTime: TimePlannerDateTime(day: 4, hour: 10, minutes: 00),
      minutesDuration: 90,
      daysDuration: 1,
      onTap: () {},
      child: Text(
        'Anglais \n 14:00',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${semester}',
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: MyAppColors.principalcolor,
            fontSize: 18,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: APIs.GetAllCreneauByemploidutemps(context, emploiID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty || snapshot.data == null) {
            return Center(child: Text('no data is availble'));
          } else {
            List<Creneau> CreneauData = List<Creneau>.from(snapshot.data!.map<Creneau>((item) => Creneau.fromJson(item)));
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TimePlanner(
                    // time will be start at this hour on table
                    startHour: 7,
                    // time will be end at this hour on table
                    endHour: 18,
                    setTimeOnAxis: false,
                    // each header is a column and a day
                    headers: cleanArray(CreneauData).map((e) => TimePlannerTitle(
                      titleStyle: TextStyle(
                          color: MyAppColors.darkblue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                      title: e.jour.toString(), // You can use e here to get the actual date or day
                    )).toList(),
                    // List of task will be show on the time planner
                    tasks: CreneauData.map((e) {
                        List<String> startTimeParts = e.horaire_debut.split(':');
                        int startHour = int.parse(startTimeParts[0]);
                        int startMinute = int.parse(startTimeParts[1]);
                        return TimePlannerTask(
                          color: MyAppColors.principalcolor,
                          dateTime: TimePlannerDateTime(
                              day: getDayNumber(e.jour),
                              hour: startHour,
                              minutes: startMinute
                          ),
                          minutesDuration: 90,
                          daysDuration: 1,
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${e.libelle}',
                                style: TextStyle(
                                    color: Colors.grey[350], fontSize: 12),
                              ),
                              Text(
                                '${e.moduleName}',
                                style: TextStyle(
                                    color: Colors.grey[350],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                '${startHour}:${startMinute}',
                                style: TextStyle(
                                    color: Colors.grey[350], fontSize: 12),
                              ),
                              Text(
                                '${e.enseignantName}',
                                style: TextStyle(
                                    color: Colors.grey[350], fontSize: 10),
                              ),
                            ],
                          ),
                        );
                    }).toList(),

                    style: TimePlannerStyle(
                      backgroundColor: Colors.white,
                      dividerColor: Colors.white,
                      showScrollBar: true,
                      horizontalTaskPadding: 5,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      )
    );
  }
}
List<Creneau> cleanArray(List<Creneau> items) {
  Set<String> uniqueModules = Set<String>();
  List<Creneau> result = [];

  for (Creneau item in items) {
    if (!uniqueModules.contains(item.jour)) {
      uniqueModules.add(item.jour);
      result.add(item);
    }
  }

  return result;
}
int getDayNumber(String dayName) {
  switch (dayName.toLowerCase()) {
    case 'lundi':
      return 1;
    case 'mardi':
      return 2;
    case 'mercredi':
      return 3;
    case 'jeudi':
      return 4;
    case 'vendredi':
      return 5;
    case 'samedi':
      return 6;
    case 'dimanche':
      return 0;
    default:
      throw ArgumentError('Invalid day name: $dayName');
  }
}