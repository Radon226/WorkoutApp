import 'dart:developer';

import 'package:flutter/material.dart';
import '../db/DatabaseHelper.dart';
import 'package:radons_workout_app/essentials/card.dart';
import 'package:radons_workout_app/essentials/weeklyRoutine.dart';
import 'package:radons_workout_app/essentials/themeTool.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
  static ThemeTool themeTool = ThemeTool();
}

class _HistoryPageState extends State<HistoryPage> {
  static Color background = HistoryPage.themeTool.getBackground();
  static Color primary = HistoryPage.themeTool.getPrimary();
  static Color secondary = HistoryPage.themeTool.getSecondary();

  String title = 'Progress';
  double appBarHeight = HistoryPage.themeTool.getAppbarHeight();

  //store and display weeks of workouts
  late List<WeeklyRoutine> listOfWeeks = [];

  @override
  void initState() {
    super.initState();
    getAllWeeklyRoutines();
  }

  void getAllWeeklyRoutines() async {
    log('historyPage - getAllWeeklyRoutines: starting');

    List<WeeklyRoutine> list = await DatabaseHelper.instance.readAllWeeklyRoutines();

    setState(() {
      listOfWeeks = list;
    });

    log('historyPage - getAllWeeklyRoutines: list ${list.toString()} || list being used ${listOfWeeks.toString()}');
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
                //column which holds week 1 and purple container
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 650,
                    child: SingleChildScrollView(
                      //allows scrolling inside container full of daycards
                      child: Column(
                        children: [
                          for (var i = 0; i < listOfWeeks.length; i++)
                            //dayCard
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: WeeklyCard(listOfWeeks[i]),
                            ),
                        ],
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
