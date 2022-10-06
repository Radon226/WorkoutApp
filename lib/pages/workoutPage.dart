import 'package:flutter/material.dart';
import 'package:radons_workout_app/essentials/textTool.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
  static TextTool textTool = TextTool();
}

class _WorkoutPageState extends State<WorkoutPage> {
  static TextStyle mainStyleStroke = TextStyle(
    fontSize: 65,
    fontFamily: 'AnnieUseYourTelescope',
    height: .82,
    letterSpacing: 6,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Colors.black,
  );

  static TextStyle mainStyle = const TextStyle(
    fontSize: 65,
    fontFamily: 'AnnieUseYourTelescope',
    height: .82,
    letterSpacing: 6,
    color: Colors.black,
  );

  String title = 'Work';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'workoutPage',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(128),
          child: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            title: WorkoutPage.textTool.writeText1(title, true),
            centerTitle: true,
            toolbarHeight: 128,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Text('workout'),
            ],
          ),
        ),
      ),
    );
  }
}
