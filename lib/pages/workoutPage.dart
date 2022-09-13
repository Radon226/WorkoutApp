import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
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

  String title = 'LETS WORK';

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
            title: Stack(
              children: [
                Text(title, style: mainStyle, textAlign: TextAlign.center),
                Text(title,
                    style: mainStyleStroke, textAlign: TextAlign.center),
              ],
            ),
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
