import 'dart:developer';

import 'package:flutter/material.dart';
import '../db/DatabaseHelper.dart';
import '../essentials/weeklyRoutine.dart';
import '../essentials/workout.dart';
import '../essentials/workoutCreator.dart';
import 'routinePage.dart';
import 'package:radons_workout_app/essentials/themeTool.dart';

class HomePage extends StatefulWidget {
  @override
  static ThemeTool themeTool = ThemeTool();
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String title = 'THE \nWORKOUT';

  static Color background = HomePage.themeTool.getBackground();
  static Color primary = HomePage.themeTool.getPrimary();
  static Color secondary = HomePage.themeTool.getSecondary();

  double appBarHeight = HomePage.themeTool.getAppbarHeight() + 28;

  List<WeeklyRoutine>? listOfWeeks;
  late WeeklyRoutine week;
  bool isDoneOnce = false;

  @override
  void initState() {
    super.initState();
    checkRoutine();
    getLatestWeek();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme
        (
          backgroundColor: primary,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: appBarHeight,
        ),
        fontFamily: 'AnnieUsedHerTelescope',
      ),
      home: Scaffold(
        backgroundColor: background,
        appBar: AppBar
        (
          title: Padding
          (
            padding: const EdgeInsets.only(top: 20),
            child: HomePage.themeTool.writeTitle(title, true),
          ),
          centerTitle: true,
        ),
        body: Center
        (
          child: Column
          (
            children: 
            [
              const SizedBox(height: 30),
              streakSection,
              const SizedBox(height: 30),
              ElevatedButton
              (
                style: ElevatedButton.styleFrom
                (
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 15),
                  side: const BorderSide(width: 6), //adds border
                  backgroundColor: secondary,
                ),
                child: HomePage.themeTool.writeTitle('START', false),
                onPressed: () {
                  log('homePage - widget: going to next page and passing weeklyroutine to it');
                  checkRoutine();
                  getLatestWeek();
                  Navigator.push(
                      context,
                      MaterialPageRoute
                      (
                          builder: (context) =>RoutinePage(weeklyRoutine: week)
                      )
                  );
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 30, bottom: 15),
                  side: const BorderSide(width: 6), //adds border
                  backgroundColor: secondary,
                ),
                child: HomePage.themeTool.writeTitle('DELETE DB', false),
                onPressed: () {
                  restart();
                },
              ),
              const SizedBox(height: 5),
              quote,
            ],
          ),
        ),
      ),
    );
  }

  Widget streakSection = Container(
    margin: const EdgeInsets.only(left: 20, right: 20),
    //color: secondary,
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: HomePage.themeTool.writeSubtitle('STREAK:', false)),
          const Placeholder(
            fallbackHeight: 170,
            fallbackWidth: 120,
          )
        ],
      ),
    ),
  );

  static String placeholderQuote =
      "You just wait. I'm going to be the biggest Chinese Star in the world.\n\nBruce Lee";

  Widget quote = Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      constraints: const BoxConstraints(maxHeight: 110), //constraints container to max height
      child: HomePage.themeTool.writeSmall(placeholderQuote, true)
  );

  Future checkRoutine() async {
    WorkoutCreator workoutCreator = WorkoutCreator();
    List<Workout> list = workoutCreator.createWorkouts(3, 8, 20, 40, 60);

    listOfWeeks = await DatabaseHelper.instance.readAllWeeklyRoutines();
    DateTime today = DateTime.now();

    //  if list from database is empty, add a routine
    //  else check if the latest added routine is up-to-date with current time, if not, add new routine
    if (listOfWeeks!.isEmpty) {
      WeeklyRoutine routine = WeeklyRoutine(week: 1, dateCreated: today, listOfWorkouts: list);

      print('homePage - checkRoutine(): ${routine.toMap()}');

      await DatabaseHelper.instance.create(routine);
      log('homePage - checkRoutine(): routine list empty, added new weekly workout to db');

      //if the created date of the latest routine + 7 days is less than today, create new routine
    } else if (listOfWeeks![listOfWeeks!.length - 1].getDate().add(const Duration(days: 6)).compareTo(DateTime.now()) < 0) {
      int latestWeek = listOfWeeks!.length;
      WeeklyRoutine routine = WeeklyRoutine(week: latestWeek + 1, dateCreated: today, listOfWorkouts: list);

      print('homePage - checkRoutine(): ${routine.toMap()}');

      await DatabaseHelper.instance.create(routine);
      log('homePage - checkRoutine(): routine list has no up to date routine, added new weekly workout to db');
    } else {
      log('homePage - checkRoutine(): db of weeks is not empty nor expired, no need for creation');
    }
  }

  void getLatestWeek() async {
    List<WeeklyRoutine> list = await DatabaseHelper.instance.readAllWeeklyRoutines();
    setState(() {
      week = list[list.length - 1];
    });

    log('homePage - getLatestWeek(): set week to latest (id ${week.getId()})');
  }

  Future restart() async {
    await DatabaseHelper.instance.deleteDatabase();

    log('homePage - restart(): database deleted');
  }

  //use to test toMap and fromMap
  //takes WeeklyRoutine object and converts to json and converts back to object to see if data retains
  //the data does retain
  Future printWorkout() async {
    WorkoutCreator workoutCreator = WorkoutCreator();
    List<Workout> list = workoutCreator.createWorkouts(3, 8, 20, 40, 60);

    WeeklyRoutine realRoutine = WeeklyRoutine(
        id: DateTime.now().hashCode,
        week: 1,
        dateCreated: DateTime.now(),
        listOfWorkouts: list);

    var objtoMap = realRoutine.toMap();

    var jsonToObj = WeeklyRoutine.fromMap(objtoMap);

    WeeklyRoutine testRoutine = jsonToObj;

    log('homePage - printWorkout(): jsonToObj ------> ${testRoutine.toMap()}');

    if (realRoutine.toMap().toString() == testRoutine.toMap().toString())
      log('both jsons are equal after conversion');
  }
}
