import 'package:flutter/material.dart';
import 'package:radons_workout_app/essentials/workout.dart';
import 'package:radons_workout_app/essentials/exercise.dart';
import 'package:radons_workout_app/essentials/textTool.dart';

class DayCard extends StatefulWidget {
  @override
  //write constructor for class DayCard here inside the main class
  int day;
  DayCard(this.workoutDay, this.day);
  Workout workoutDay;
  static TextTool textTool =
      TextTool(); //declare TextTool inside main class and call
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  //use late, otherwise there is an error
  late Workout workoutDay;
  late String nameOfWorkout;
  late List<dynamic> warmups;
  late List<dynamic> exercs;
  late List<dynamic> stretches;
  late int day;
  bool _customTileExpanded = false;

  @override
  //remember to assign variables inside initState before super.initState()
  void initState() {
    //use widget.variableName to get value of variable from main class DayCard
    workoutDay = widget.workoutDay;
    day = widget.day;
    nameOfWorkout = workoutDay.getName();
    warmups = workoutDay.getWarmup();
    exercs = workoutDay.getExerc();
    stretches = workoutDay.getStretch();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      //the container that holds the expansion tile
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ExpansionTile(
          //the expansion tile
          title: DayCard.textTool.writeText2('Day $day: $nameOfWorkout', false),
          trailing: Icon(_customTileExpanded
              ? Icons.arrow_drop_down_circle
              : Icons.arrow_drop_down),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          children: <Widget>[
            //contains the list of workout exercises (the children of expansion tile)
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
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

                      for (Exercise index in exercs)
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
}

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
          Expanded(child: DayCard.textTool.writeText2(text, false)),
        ],
      ),
    );
  }
}
