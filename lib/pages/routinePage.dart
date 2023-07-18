import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'dart:developer';
import 'workoutPage.dart';
import 'package:radons_workout_app/essentials/card.dart';
import 'package:radons_workout_app/essentials/weeklyRoutine.dart';
import 'package:radons_workout_app/essentials/workout.dart';
import 'package:radons_workout_app/essentials/themeTool.dart';

class RoutinePage extends StatefulWidget {
  static ThemeTool themeTool = ThemeTool();

  final WeeklyRoutine weeklyRoutine;

  const RoutinePage({
    Key? key,
    required this.weeklyRoutine,
  }) : super(key: key);

  @override
  State<RoutinePage> createState() =>
      _RoutinePageState(weeklyRoutine: weeklyRoutine);
}

class _RoutinePageState extends State<RoutinePage> {
  static Color background = RoutinePage.themeTool.getBackground();
  static Color primary = RoutinePage.themeTool.getPrimary();
  static Color secondary = RoutinePage.themeTool.getSecondary();

  List<Workout>? listOfWorkouts;
  WeeklyRoutine weeklyRoutine;
  late Workout todaysWorkout;

  _RoutinePageState({required this.weeklyRoutine});

  bool _customTileExpanded = false;
  String title = 'Routine';
  double appBarHeight = RoutinePage.themeTool.getAppbarHeight();

  @override
  void initState() {
    super.initState();
    log('routinePage - initState(): id ${weeklyRoutine.getId()}');
    getListOfWorkouts();
    getTodaysWorkout();
  }

  void getListOfWorkouts() async {
    setState(() {
      listOfWorkouts = weeklyRoutine.getlistOfWorkouts();
    });
  }

  void getTodaysWorkout() async {
    DateTime today = DateTime
        .now(); //for some reason, this gives one day ahead of act today (global time?)

    for (int i = 0; i < listOfWorkouts!.length; i++) {
      if (DateUtils.isSameDay(listOfWorkouts![i].getDate(), today)) {
        setState(() {
          todaysWorkout = listOfWorkouts![i];
        });
        log('routinePage - getTodaysWorkout(): todays workout is ${todaysWorkout.getName()}');
      }
    }
  }

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
                    child: RoutinePage.themeTool.writeSubtitle('Week ${weeklyRoutine.getWeek()}', false),
                  ),
                  SizedBox(
                    height: 550,
                    child: SingleChildScrollView(
                      //allows scrolling inside container full of daycards
                      child: Column(
                        children: [
                          for (var i = 0; i < listOfWorkouts!.length; i++)  
                            //dayCard
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                              child: WorkoutCard(listOfWorkouts![i]),
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
                  //if button is pressed, send data of today's workout to workoutPage
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkoutPage(weeklyRoutine: weeklyRoutine, workout: todaysWorkout)));
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
