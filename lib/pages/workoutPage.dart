import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:radons_workout_app/essentials/themeTool.dart';

import '../essentials/exercise.dart';
import '../essentials/weeklyRoutine.dart';
import '../essentials/workout.dart';
import '../db/DatabaseHelper.dart';

class WorkoutPage extends StatefulWidget {
  final WeeklyRoutine weeklyRoutine;
  final Workout workout;
  const WorkoutPage(
      {Key? key, required this.weeklyRoutine, required this.workout})
      : super(key: key);

  @override
  State<WorkoutPage> createState() =>
      _WorkoutPageState(weeklyRoutine: weeklyRoutine, todaysWorkout: workout);
  static ThemeTool themeTool = ThemeTool();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String title = 'Workout';
  double appBarHeight = WorkoutPage.themeTool.getAppbarHeight();
  static Color background = WorkoutPage.themeTool.getBackground();
  static Color primary = WorkoutPage.themeTool.getPrimary();
  static Color secondary = WorkoutPage.themeTool.getSecondary();

  //this weeks routine, used to update database
  final WeeklyRoutine weeklyRoutine;

  //todays workout, used to get today's list of exercises
  final Workout todaysWorkout;

  late Queue<Exercise> queueOfExercises = Queue<Exercise>();
  late List<Exercise> listOfFour = [];
  late int restTime;
  late String tips = "tips tips tips";
  late bool start = false;
  late bool finish = false;

  _WorkoutPageState({required this.weeklyRoutine, required this.todaysWorkout});

  @override
  void initState() {
    super.initState();
    queueExercises();
    assignExercs();
    log('workoutPage: Todays workout is ${todaysWorkout.getName()} | ${todaysWorkout.getDate()}');
    log('workoutPage: start = $start');
    log('workoutPage: finish = $finish | ${todaysWorkout.getStateOfWorkout()}');
  }

  void queueExercises() {
    List<Exercise> listOfExercs = todaysWorkout.getListOfExercs();
    setState(() {
      queueOfExercises.addAll(listOfExercs);
    });
  }

  void goNext() {
    queueOfExercises.removeFirst();
    assignExercs();
    log('workoutPage - goNext(): list isEmpty = ${queueOfExercises.isEmpty}');
  }

  void assignExercs() {
    listOfFour = queueOfExercises.take(4).toList();
  }

  Future finishWorkout() async {
    finish = true;
    log('workoutPage - onTap(): finish = $finish');

    WeeklyRoutine updatedWeekly = weeklyRoutine;

    int i = 0;
    bool isFound = false;
    DateTime today = DateTime.now();

    //Previosuly, there was no incrementation for i which led to an infinite update loop.
    while (i < updatedWeekly.listOfWorkouts.length || !isFound) {
      if (DateUtils.isSameDay(
          updatedWeekly.listOfWorkouts[i].getDate(), today)) {
        isFound = true;
        updatedWeekly.getlistOfWorkouts().elementAt(i).finishWorkout();
        Workout workout = updatedWeekly.getlistOfWorkouts().elementAt(i);
        log('workoutPage - onTap(): Workout being updated -> ${workout.getName()} | ${workout.getDate()} | ${workout.getStateOfWorkout()}');
      }

      i++;
    }

    log('workoutPage - onTap(): Updating WeeklyRoutine in db');
    await DatabaseHelper.instance.update(updatedWeekly);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            //appbar
            backgroundColor: primary,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: WorkoutPage.themeTool.writeTitle(title, true),
            ),
            centerTitle: true,
            toolbarHeight: appBarHeight,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  //color: background,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      if (!start) ...[
                        WorkoutPage.themeTool.writeSubtitle('Ready', true),
                      ],
                      if (start && listOfFour.isNotEmpty) ...[
                        if (listOfFour.first.getTime() != 0) ...[
                          WorkoutPage.themeTool.writeSubtitle('Time', true),
                        ] else if (listOfFour.first.getReps() != 0) ...[
                          WorkoutPage.themeTool.writeSubtitle('Sets', true),
                        ],
                      ],
                      const SizedBox(height: 10),
                      WorkoutPage.themeTool.writeNorm(tips, true),
                      const SizedBox(height: 25),

                      //PLACE ANIMATION/GIF/SPRITE HERE

                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: InkWell(
                          onTap: () {
                            //use setState whenever you want to update a widget
                            if (!start) {
                              setState(() {
                                start = true;

                                if (listOfFour.first.getType() == 0) {
                                  title = "Warmup";
                                }
                                if (listOfFour.first.getType() == 1) {
                                  title = "Main";
                                }
                                if (listOfFour.first.getType() == 2) {
                                  title = "Stretches";
                                }
                              });
                              log('workoutPage - onTap(): start = $start');
                            } else if (start && queueOfExercises.isNotEmpty) {
                              setState(() {
                                goNext();
                                if (queueOfExercises.isNotEmpty) {
                                  if (listOfFour.first.getType() == 0) {
                                    title = "Warmup";
                                  }
                                  if (listOfFour.first.getType() == 1) {
                                    title = "Main";
                                  }
                                  if (listOfFour.first.getType() == 2) {
                                    title = "Stretches";
                                  }
                                } else {
                                  title = "Finished";
                                  finishWorkout();
                                }
                              });
                            }
                          },
                          highlightColor: Colors.red,
                          child: Placeholder(
                            color: secondary,
                            fallbackHeight: 330,
                            fallbackWidth: 210,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (start && listOfFour.isNotEmpty) ...[
                            if (listOfFour.first.getReps() != 0) ...[
                              WorkoutPage.themeTool.writeSubtitle(
                                  '${listOfFour.first.getReps()} ', true),
                            ],
                            WorkoutPage.themeTool.writeSubtitle(
                                listOfFour.first.getName(), true),
                          ]
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 0,
                thickness: 7,
                color: Colors.black,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  //color: background,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 1; i < listOfFour.length; i++) ...[
                        if (!start) ...[
                          Center(
                            child: WorkoutPage.themeTool
                                .writeNorm(listOfFour[i - 1].getName(), true),
                          ),
                        ] else ...[
                          Center(
                            child: WorkoutPage.themeTool
                                .writeNorm(listOfFour[i].getName(), true),
                          ),
                        ]
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
