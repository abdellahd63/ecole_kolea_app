import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/CalendarTeacher.dart';
import 'package:ecole_kolea_app/Model/Creneau.dart';
import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';

class TeacherPlanning extends StatelessWidget {
  TeacherPlanning({super.key, required String this.semester, required this.emploiID});
  String semester;
  String emploiID;

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
          future: APIs.GetAllCalendarForTeacher(context, emploiID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data!.isEmpty || snapshot.data == null) {
              return Center(child: Text('no data is availble'));
            } else {
              List<CalendarTeacher> CalendarTeacherData = List<CalendarTeacher>.from(snapshot.data!.map<CalendarTeacher>((item) => CalendarTeacher.fromJson(item)));
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
                      headers: cleanArray(CalendarTeacherData).map((e) => TimePlannerTitle(
                        titleStyle: TextStyle(
                            color: MyAppColors.darkblue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                        title: e.jour.toString(), // You can use e here to get the actual date or day
                      )).toList(),
                      // List of task will be show on the time planner
                      tasks: CalendarTeacherData.map((e) {
                        List<String> startTimeParts = e.horaireDebut.split(':');
                        int startHour = int.parse(startTimeParts[0]);
                        int startMinute = int.parse(startTimeParts[1]);
                        List<String> endTimeParts = e.horaireFin.split(':');
                        int endHour = int.parse(endTimeParts[0]);
                        int endMinute = int.parse(endTimeParts[1]);
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
                                '${e.moduleAssociation.libelle}',
                                style: TextStyle(
                                    color: Colors.grey[350],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                '${startHour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}   ${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  color: Colors.grey[350],
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${e.moduleAssociation.filiereAssociation.libelle}',
                                style: TextStyle(
                                    color: Colors.grey[350], fontSize: 10),
                              ),
                              if(e.groupeAssociation != null)
                                Text(
                                  '${e.groupeAssociation?.sectionAssociation.libelle}',
                                  style: TextStyle(
                                  color: Colors.grey[350], fontSize: 10),
                                ),
                              if(e.groupeAssociation != null)
                                Text(
                                '${e.groupeAssociation?.libelle}',
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
List<CalendarTeacher> cleanArray(List<CalendarTeacher> items) {
  Set<String> uniqueModules = Set<String>();
  List<CalendarTeacher> result = [];

  for (CalendarTeacher item in items) {
    if (!uniqueModules.contains(item.jour)) {
      uniqueModules.add(item.jour);
      result.add(item);
    }
  }

  return result;
}
