import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../db/DatabaseHelper.dart';
import '../essentials/exercise.dart';
import '../essentials/weeklyRoutine.dart';
import '../essentials/workout.dart';
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

  WeeklyRoutine? week;
  List<Workout>? listOfDays;
  List<WeeklyRoutine>? listOfWeeks;
  bool isDoneOnce = false;

  Future checkRoutine() async {
    List<Workout> list = createWorkouts(3, 8, 20, 40, 60);

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
    } else if (listOfWeeks![listOfWeeks!.length - 1]
            .getDate()
            .add(const Duration(days: 6))
            .compareTo(DateTime.now()) <
        0) {
      int latestWeek = listOfWeeks!.length;

      WeeklyRoutine routine = WeeklyRoutine(week: latestWeek + 1, dateCreated: today, listOfWorkouts: list);

      print('homePage - checkRoutine(): ${routine.toMap()}');

      await DatabaseHelper.instance.create(routine);
      log('homePage - checkRoutine(): routine list has no up to date routine, added new weekly workout to db');
    } else {
      log('homePage - checkRoutine(): db of weeks is not empty nor expired, no need for creation');
    }
  }

  Future restart() async {
    await DatabaseHelper.instance.deleteDatabase();

    log('homePage - restart(): database deleted');
  }

  //use to test toMap and fromMap
  //takes WeeklyRoutine object and converts to json and converts back to object to see if data retains
  //the data does retain
  Future printWorkout() async {
    List<Workout> list = createWorkouts(3, 8, 20, 40, 60);

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: primary,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: appBarHeight,
        ),
        fontFamily: 'AnnieUsedHerTelescope',
      ),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: HomePage.themeTool.writeTitle(title, true),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                streakSection,
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 30, bottom: 15),
                    side: const BorderSide(width: 6), //adds border
                    backgroundColor: secondary,
                  ),
                  child: HomePage.themeTool.writeTitle('START', false),
                  onPressed: () {
                    if (!isDoneOnce) {
                      isDoneOnce = true;
                      checkRoutine();
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RoutinePage()));
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
      constraints: const BoxConstraints(
          maxHeight: 110), //constraints container to max height
      child: HomePage.themeTool.writeSmall(placeholderQuote, true));

  //assigns workout to corresponding day and adds them to array weekRoutine
  List<Workout> createWorkouts(
      int sets, hardReps, mediumReps, easyReps, double time) {
    Workout upperBody1;
    Workout lowerBody2;
    Workout rest3;
    Workout upperBody4;
    Workout lowerBody5;
    Workout rest6;
    Workout test7;

    DateTime today = DateTime.now();

    upperBody1 = createWorkout('UPPER', 60, today, 0);
    lowerBody2 =
        createWorkout('LOWER', 60, today.add(const Duration(days: 1)), 1);
    rest3 = createWorkout('REST', 0, today.add(const Duration(days: 2)), 1);
    upperBody4 =
        createWorkout('UPPER', 60, today.add(const Duration(days: 3)), 1);
    lowerBody5 =
        createWorkout('LOWER', 60, today.add(const Duration(days: 4)), 1);
    rest6 = createWorkout('REST', 0, today.add(const Duration(days: 5)), 1);
    test7 = createWorkout('TEST', 60, today.add(const Duration(days: 6)), 1);

    return <Workout>[
      upperBody1,
      lowerBody2,
      rest3,
      upperBody4,
      lowerBody5,
      rest6,
      test7,
    ];
  }

  //returns workout object
  //workoutType: 0 if upper, 1 if lower, 2 if test
  //Exercise(this._name, this._type, this._sets, this._reps, this._time);
  Workout createWorkout(
      String name, int restTime, DateTime date, int workoutType) {
    List<Exercise> upperExercises = createUpperExercises(5, 5, 5, 5, 5);
    List<Exercise> lowerExercises = createLowerExercises(5, 5, 5, 5, 5);
    List<Exercise> testExercises = [
      //warmups
      Exercise(name: 'Jumping Jacks', type: 0, sets: 0, reps: 0, time: 60),
      Exercise(name: 'Arm Circles', type: 0, sets: 0, reps: 2, time: 20),
      Exercise(name: 'Side Planks', type: 0, sets: 2, reps: 0, time: 45),

      //main UPPER BODY EXERCISES (6)
      Exercise(name: 'Pushups', type: 1, sets: 1, reps: 0, time: 60),
      Exercise(name: 'Pullups', type: 1, sets: 1, reps: 0, time: 60),

      Exercise(name: 'Squats', type: 1, sets: 1, reps: 0, time: 60),
      Exercise(name: 'Split Squats', type: 1, sets: 1, reps: 0, time: 60)
    ];

    if (workoutType == 0) {
      return Workout(
          name: name,
          restPerSet: restTime,
          date: date,
          listOfExcercs: upperExercises);
    }

    if (workoutType == 1) {
      return Workout(
          name: name,
          restPerSet: restTime,
          date: date,
          listOfExcercs: lowerExercises);
    }

    return Workout(
        name: name,
        restPerSet: restTime,
        date: date,
        listOfExcercs: testExercises);
  }

  //returns a custom list of exercises
  List<Exercise> createUpperExercises(
          int sets, hardReps, mediumReps, easyReps, double time) =>
      [
        //warmups
        Exercise(name: 'Jumping Jacks', type: 0, sets: 0, reps: 0, time: 60),
        Exercise(name: 'Arm Circles', type: 0, sets: 2, reps: 20, time: 0),
        Exercise(name: 'Side Planks', type: 0, sets: 2, reps: 0, time: 45),

        //main UPPER BODY EXERCISES (6)
        Exercise(
            name: 'Pushups', type: 1, sets: sets, reps: mediumReps, time: time),
        Exercise(
            name: 'Dips', type: 1, sets: sets, reps: mediumReps, time: time),
        Exercise(name: 'Rows', type: 1, sets: sets, reps: hardReps, time: time),
        Exercise(
            name: 'Pullups', type: 1, sets: sets, reps: hardReps, time: time),
        Exercise(
            name: 'Chinups', type: 1, sets: sets, reps: hardReps, time: time),
        Exercise(name: 'Planks', type: 1, sets: sets, reps: 0, time: time),

        //STRETCHES AFTER UPPER WORKOUT (5)
        Exercise(
            name: 'Arm And Wrist Stretch',
            type: 2,
            sets: 2,
            reps: 0,
            time: time / 2),
        Exercise(name: 'Child Pose', type: 2, sets: 0, reps: 0, time: time),
        Exercise(name: 'Cobra Pose', type: 2, sets: 0, reps: 0, time: time),
        Exercise(name: 'Bicep Stretch', type: 2, sets: 0, reps: 0, time: time),
        Exercise(name: 'Tricep Stretch', type: 2, sets: 0, reps: 0, time: time),
      ];

  List<Exercise> createLowerExercises(
          int sets, hardReps, mediumReps, easyReps, double time) =>
      [
        //warmups
        Exercise(name: 'Jumping Jacks', type: 0, sets: 0, reps: 0, time: 60),
        Exercise(name: 'Arm Circles', type: 0, sets: 2, reps: 20, time: 0),
        Exercise(name: 'Side Planks', type: 0, sets: 2, reps: 0, time: 45),

        //main LOWER BODY EXERCISES (6)
        Exercise(
            name: 'Calf Raises',
            type: 1,
            sets: sets,
            reps: mediumReps,
            time: time),
        Exercise(
            name: 'Glute Bridges',
            type: 1,
            sets: sets,
            reps: easyReps,
            time: time),
        Exercise(
            name: 'Squats', type: 1, sets: sets, reps: mediumReps, time: time),
        Exercise(
            name: 'Split Squats',
            type: 1,
            sets: sets,
            reps: hardReps,
            time: time),
        Exercise(
            name: 'Lateral Lunges',
            type: 1,
            sets: sets,
            reps: mediumReps,
            time: time),
        Exercise(
            name: 'Bicycle Crunches',
            type: 1,
            sets: sets,
            reps: mediumReps,
            time: time),

        //STRETCHES AFTER LOWER WORKOUT (4)
        Exercise(
            name: 'Quad Stretch', type: 2, sets: 2, reps: 0, time: time / 2),
        Exercise(
            name: 'Side Lunge Stretch',
            type: 2,
            sets: 2,
            reps: 0,
            time: time / 2),
        Exercise(
            name: 'Hamstring Stretch',
            type: 2,
            sets: 2,
            reps: 0,
            time: time / 2),
        Exercise(name: 'Butterfly', type: 2, sets: 0, reps: 0, time: time),
      ];
}
