import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';

class PlanningCours extends StatelessWidget {
  PlanningCours({super.key});


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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          
          Expanded(
            child: TimePlanner(
              // time will be start at this hour on table
              startHour: 7,
              // time will be end at this hour on table
              endHour: 18,
              
              

              // each header is a column and a day
              headers: [
                TimePlannerTitle(
                  //date: "3/10/2021",
                  title: "Samdi",
                ),
                TimePlannerTitle(
                  //date: "3/11/2021",
                  title: "Dimanche",
                ),
                TimePlannerTitle(
                  //date: "3/12/2021",
                  title: "Lundi",
                ),

                TimePlannerTitle(
                  //date: "3/12/2021",
                  title: "Mardi",
                ),

                TimePlannerTitle(
                  //date: "3/12/2021",
                  title: "Mercredi",
                ),

                TimePlannerTitle(
                  //date: "3/12/2021",
                  title: "Jeudi",
                ),
              ],
              // List of task will be show on the time planner
              tasks: tasks,

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
      ),
    );
  }
}