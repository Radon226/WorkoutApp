import 'package:flutter/material.dart';
import 'package:radons_workout_app/essentials/themeTool.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
  static ThemeTool themeTool = ThemeTool();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String title = 'Work';
  double appBarHeight = WorkoutPage.themeTool.getAppbarHeight();
  static Color background = WorkoutPage.themeTool.getBackground();
  static Color primary = WorkoutPage.themeTool.getPrimary();
  static Color secondary = WorkoutPage.themeTool.getSecondary();

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
                      SizedBox(height: 20),
                      WorkoutPage.themeTool.writeSubtitle('# Sets Left', true),
                      SizedBox(height: 10),
                      WorkoutPage.themeTool.writeNorm('Tips tips tips', true),
                      SizedBox(height: 10),
                      //PLACE ANIMATION HERE
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Placeholder(
                          color: secondary,
                          fallbackHeight: 210,
                          fallbackWidth: 210,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WorkoutPage.themeTool.writeSubtitle('#', true),
                          WorkoutPage.themeTool.writeSubtitle('Exercise', true),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Divider(
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
                      SizedBox(height: 15),
                      Center(
                        child:
                            WorkoutPage.themeTool.writeNorm('Exercise1', true),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child:
                            WorkoutPage.themeTool.writeNorm('Exercise2', true),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child:
                            WorkoutPage.themeTool.writeNorm('Exercise3', true),
                      ),
                      SizedBox(height: 15),
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
