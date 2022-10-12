import 'package:flutter/material.dart';
import 'workoutPage.dart';
import 'package:radons_workout_app/essentials/workoutCard.dart';
import 'package:radons_workout_app/essentials/weeklyRoutine.dart';
import 'package:radons_workout_app/essentials/workout.dart';
import 'package:radons_workout_app/essentials/themeTool.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
  static ThemeTool themeTool = ThemeTool();
}

class _HistoryPageState extends State<HistoryPage> {
  //store and display weeks of workouts
  late List<WeeklyRoutine> listOfWeeks;

  static Color background = HistoryPage.themeTool.getBackground();
  static Color primary = HistoryPage.themeTool.getPrimary();
  static Color secondary = HistoryPage.themeTool.getSecondary();

  bool _customTileExpanded = false;
  String title = 'Progress';
  double appBarHeight = HistoryPage.themeTool.getAppbarHeight();

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
              child: HistoryPage.themeTool.writeTitle(title, true),
            ),
            centerTitle: true,
            toolbarHeight: appBarHeight,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: HistoryPage.themeTool.writeSubtitle('', false),
                  ),
                  SizedBox(
                    height: 370,
                    child: SingleChildScrollView(
                      //should list all weekcards
                      child: Column(
                        children: [],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
