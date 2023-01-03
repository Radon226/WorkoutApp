import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  late List<Exercise> warmups;
  late List<Exercise> mainExercs;
  late List<Exercise> stretches;

  late DateTime date;
  late String dateFormatted;
  bool _customTileExpanded = false;

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
    if (nameOfWorkout == "REST") {
      return restCard();
    } else {
      return nonRestCard();
    }
  }

  Widget nonRestCard() {
    return Container(
      //the container that holds the expansion tile
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ExpansionTile(
          //the expansion tile
          title: WorkoutCard.themeTool
              .writeNorm('$dateFormatted: $nameOfWorkout', false),
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

  Widget restCard() {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ExpansionTile(
          title: WorkoutCard.themeTool
              .writeNorm('$dateFormatted: $nameOfWorkout', false),
          backgroundColor: Color.fromARGB(255, 233, 248, 255),
          collapsedBackgroundColor: Colors.white,
        ),
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
