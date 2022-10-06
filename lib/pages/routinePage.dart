import 'package:flutter/material.dart';
import 'workoutPage.dart';
import 'package:radons_workout_app/essentials/dayCard.dart';
import 'package:radons_workout_app/essentials/weeklyRoutine.dart';
import 'package:radons_workout_app/essentials/workout.dart';
import 'package:radons_workout_app/essentials/textTool.dart';

class RoutinePage extends StatefulWidget {
  @override
  State<RoutinePage> createState() => _RoutinePageState();
  static TextTool textTool = TextTool();
}

class _RoutinePageState extends State<RoutinePage> {
  late WeeklyRoutine week;
  late List<Workout> listOfWorkout;

  void createRoutine() {
    week = WeeklyRoutine();
    week.createWorkouts(7, 7, 7, 7, 60);
    listOfWorkout = week.getRoutine();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createRoutine();
  }

  bool _customTileExpanded = false;
  String title = 'The \n Routine';
  double appBarHeight = 128;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            //appbar
            backgroundColor: Color.fromARGB(255, 159, 196, 226),
            elevation: 0,
            title: RoutinePage.textTool.writeText1('The \nRoutine', true),
            centerTitle: true,
            toolbarHeight: appBarHeight,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                //blue container that holds week 1 and purple container
                constraints:
                    const BoxConstraints(minHeight: 430, maxHeight: 430),
                color: Colors.blue,
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  //column which holds week 1 and purple container
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: RoutinePage.textTool.writeText2('Week 1', false),
                    ),
                    Container(
                      height: 370,
                      color: Colors.purpleAccent,
                      child: SingleChildScrollView(
                        //allows scrolling inside container full of daycards
                        child: Column(
                          children: [
                            Padding(
                              //daycard
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: DayCard(listOfWorkout[0], 1),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: DayCard(listOfWorkout[1], 2),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: DayCard(listOfWorkout[2], 3),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: DayCard(listOfWorkout[3], 4),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: DayCard(listOfWorkout[4], 5),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: DayCard(listOfWorkout[5], 6),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: DayCard(listOfWorkout[6], 7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WorkoutPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 20, bottom: 10),
                    side: const BorderSide(width: 6), //adds border
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: RoutinePage.textTool.writeText2('START', false)),
            ],
          ),
        ),
      ),
    );
  }
}
