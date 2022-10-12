import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

import 'workoutPage.dart';
import 'package:radons_workout_app/essentials/workoutCard.dart';
import 'package:radons_workout_app/essentials/weeklyRoutine.dart';
import 'package:radons_workout_app/essentials/workout.dart';
import 'package:radons_workout_app/essentials/themeTool.dart';

class RoutinePage extends StatefulWidget {
  @override
  State<RoutinePage> createState() => _RoutinePageState();
  static ThemeTool themeTool = ThemeTool();
}

class _RoutinePageState extends State<RoutinePage> {
  static Color background = RoutinePage.themeTool.getBackground();
  static Color primary = RoutinePage.themeTool.getPrimary();
  static Color secondary = RoutinePage.themeTool.getSecondary();

  late WeeklyRoutine week;
  late List<Workout> listOfWorkout;

  void createRoutine(int weekCurr, DateTime dateCreated) {
    week = WeeklyRoutine(weekCurr, dateCreated);
    week.createWorkouts(7, 7, 7, 7, 60);

    listOfWorkout = week.getWeekRoutine();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DateTime dateCreated = DateTime.now();
    createRoutine(0, dateCreated);
  }

  bool _customTileExpanded = false;
  String title = 'Routine';
  double appBarHeight = RoutinePage.themeTool.getAppbarHeight();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: primary,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RoutinePage.themeTool.writeTitle(title, true),
            ),
            centerTitle: true,
            toolbarHeight: appBarHeight,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Column(
                //column which holds week 1 and purple container
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: RoutinePage.themeTool.writeSubtitle('Week 1', false),
                  ),
                  SizedBox(
                    height: 370,
                    child: SingleChildScrollView(
                      //allows scrolling inside container full of daycards
                      child: Column(
                        children: [
                          Padding(
                            //daycard
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkout[0]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkout[1]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkout[2]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkout[3]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkout[4]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkout[5]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkout[6]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WorkoutPage()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 20, bottom: 10),
                  side: const BorderSide(width: 6), //adds border
                  backgroundColor: secondary,
                ),
                child: RoutinePage.themeTool.writeSubtitle('START', false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
