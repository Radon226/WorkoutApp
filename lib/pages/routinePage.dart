import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'dart:developer';
import 'workoutPage.dart';
import 'package:radons_workout_app/essentials/workoutCard.dart';
import 'package:radons_workout_app/essentials/weeklyRoutine.dart';
import 'package:radons_workout_app/essentials/workout.dart';
import 'package:radons_workout_app/essentials/themeTool.dart';
import 'package:radons_workout_app/db/databaseHelper.dart';
import 'package:radons_workout_app/essentials/exercise.dart';

class RoutinePage extends StatefulWidget {
  static ThemeTool themeTool = ThemeTool();

  final WeeklyRoutine? routine;

  const RoutinePage({
    Key? key,
    this.routine,
  }) : super(key: key);

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  static Color background = RoutinePage.themeTool.getBackground();
  static Color primary = RoutinePage.themeTool.getPrimary();
  static Color secondary = RoutinePage.themeTool.getSecondary();

  List<Workout>? listOfWorkouts;

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
                          /* Padding(
                            //daycard
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkouts![0]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkouts![1]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkouts![2]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkouts![3]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkouts![4]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkouts![5]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: WorkoutCard(listOfWorkouts![6]),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  //if button is pressed, send data of today's workout to workoutPage
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
