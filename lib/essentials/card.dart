// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radons_workout_app/essentials/weeklyRoutine.dart';

import 'package:radons_workout_app/essentials/workout.dart';
import 'package:radons_workout_app/essentials/exercise.dart';
import 'package:radons_workout_app/essentials/themeTool.dart';

//Card that is listed for the weekly routine. Contains the day and type of workout.
class WorkoutCard extends StatefulWidget {
  @override
  //declare TextTool inside main class and call
  static ThemeTool themeTool = ThemeTool();

  //write constructor for class WorkoutCard here inside the main class
  Workout workout;

  WorkoutCard(this.workout, {super.key});

  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  //use late when initializing only, otherwise there is an error
  late Workout workout;
  late String nameOfWorkout;

  late List<Exercise> warmups = [];
  late List<Exercise> mainExercs = [];
  late List<Exercise> stretches = [];

  late DateTime date;
  late String dateFormatted;

  @override
  //remember to assign variables inside initState before super.initState()
  void initState() {
    //use widget.variableName to get value of variable from main class WorkoutCard
    workout = widget.workout;
    nameOfWorkout = workout.getName();

    separateExercs();

    date = workout.getDate();
    dateFormatted = DateFormat('MM/dd').format(date);
    super.initState();
  }

  void separateExercs() {
    List<Exercise> allExercs = workout.getListOfExercs();

    for (int i = 0; i < allExercs.length; i++) {
      if (allExercs[i].getType() == 0) warmups.add(allExercs[i]);
      if (allExercs[i].getType() == 1) mainExercs.add(allExercs[i]);
      if (allExercs[i].getType() == 2) stretches.add(allExercs[i]);
    }
  }

  Widget build(BuildContext context) {
    int type = 0;

    if (isDateExpired()) type = 1;

    if (isToday()) type = 2;

    if (nameOfWorkout == "REST") {
      return restCard(type);
    } else {
      return nonRestCard(type);
    }
  }

  Widget nonRestCard(int type) {
    return Container(
      //the container that holds the expansion tile
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ExpansionTile(
          //the expansion tile
          title: selectTitle(type),
          backgroundColor: Color.fromARGB(255, 233, 248, 255),
          collapsedBackgroundColor: Colors.white,
          children: <Widget>[
            //contains the list of workout exercises (the children of expansion tile)
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      listItem('Warmup'),
                      //for loop that prints out name of exercises
                      for (Exercise index in warmups)
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: listItem(index.getName()),
                        ),

                      listItem('Workout'),

                      for (Exercise index in mainExercs)
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: listItem(index.getName()),
                        ),

                      listItem('Stretches'),

                      for (Exercise index in stretches)
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: listItem(index.getName()),
                        ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget restCard(int type) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ExpansionTile(
          title: selectTitle(type),
          backgroundColor: Color.fromARGB(255, 233, 248, 255),
          collapsedBackgroundColor: Colors.white,
        ),
      ),
    );
  }

  bool isDateExpired() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    if (DateTime(date.year, date.month, date.day).isBefore(today)) {
      return true;
    }

    return false;
  }

  bool isToday() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    if (DateTime(date.year, date.month, date.day).isAtSameMomentAs(today)) {
      return true;
    }

    return false;
  }

  //if 1, strike, if 2, circle, else do nothing
  Widget selectTitle(int type) {
    //switch case
    if(workout.isFinished)
    {
      return StrikeThroughWidget(
            child: WorkoutCard.themeTool
                .writeNorm('$dateFormatted: $nameOfWorkout', false));
    }

    switch (type) {
      case 1:
        return StrikeThroughWidget(
            child: WorkoutCard.themeTool
                .writeNorm('$dateFormatted: $nameOfWorkout', false));
      case 2:
        return CircleWidget(
            child: WorkoutCard.themeTool
                .writeNorm('$dateFormatted: $nameOfWorkout', false));
      default:
        return WorkoutCard.themeTool
            .writeNorm('$dateFormatted: $nameOfWorkout', false);
    }
  }
}

class WeeklyCard extends StatefulWidget {
  @override
  //declare TextTool inside main class and call
  static ThemeTool themeTool = ThemeTool();

  //write constructor for class WorkoutCard here inside the main class
  WeeklyRoutine weeklyRoutine;

  WeeklyCard(this.weeklyRoutine, {super.key});

  State<WeeklyCard> createState() => _WeeklyCardState();
}

class _WeeklyCardState extends State<WeeklyCard> {
  //use late when initializing only, otherwise there is an error
  late WeeklyRoutine weeklyRoutine;
  late List<Workout> listOfWorkouts;

  @override
  //remember to assign variables inside initState before super.initState()
  void initState() {
    //use widget.variableName to get value of variable from main class WorkoutCard
    weeklyRoutine = widget.weeklyRoutine;
    listOfWorkouts = weeklyRoutine.getlistOfWorkouts();

    super.initState();
  }

  Widget build(BuildContext context) {
    return weeklyCard();
  }

  Widget weeklyCard() {
    String startDate = formatDate(listOfWorkouts[0].getDate());
    String endDate = formatDate(listOfWorkouts[listOfWorkouts.length - 1].getDate());

    return Container(
      //the container that holds the expansion tile
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ExpansionTile(
          //the expansion tile
          title: WorkoutCard.themeTool.writeNorm('Week ${weeklyRoutine.getWeek()}: $startDate - $endDate', false),
          backgroundColor: Color.fromARGB(255, 233, 248, 255),
          collapsedBackgroundColor: Colors.white,
          children: <Widget>[
            //contains the list of workout exercises (the children of expansion tile)
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //for loop that prints out name of exercises
                      for (Workout workout in listOfWorkouts)
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: listItem('${formatDate(workout.getDate())} ${workout.getName()}'),
                        ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('MM/dd').format(date);
  }
}

class StrikeThroughWidget extends StatelessWidget {
  final Widget _child;

  StrikeThroughWidget({Key? key, required Widget child})
      : this._child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _child,
      padding: EdgeInsets.symmetric(
          horizontal:
              8), // this line is optional to make strikethrough effect outside a text
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/strikethrough.png'),
            fit: BoxFit.fitWidth),
      ),
    );
  }
}

class CircleWidget extends StatelessWidget {
  final Widget _child;

  CircleWidget({Key? key, required Widget child})
      : this._child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _child,
      padding: EdgeInsets.symmetric(
          horizontal:
              8), // this line is optional to make strikethrough effect outside a text
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/circle.png'),
            fit: BoxFit.fitWidth),
      ),
    );
  }
}

//Used to list an item inside the card
class listItem extends StatelessWidget {
  listItem(this.text);
  String text;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 10),
            child: Icon(Icons.circle, size: 5),
          ),
          Expanded(child: WorkoutCard.themeTool.writeNorm(text, false)),
        ],
      ),
    );
  }
}
