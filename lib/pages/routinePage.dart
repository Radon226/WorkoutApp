import 'package:flutter/material.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({Key? key}) : super(key: key);

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
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

  static TextStyle secStyleStroke = TextStyle(
    fontSize: 48,
    fontFamily: 'AnnieUseYourTelescope',
    height: .82,
    letterSpacing: 6,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Colors.black,
  );

  static TextStyle secStyle = const TextStyle(
    fontSize: 48,
    fontFamily: 'AnnieUseYourTelescope',
    height: .82,
    letterSpacing: 6,
    color: Colors.black,
  );

  String title = 'The \n Routine';
  double appBarHeight = 128;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 159, 196, 226),
            elevation: 0,
            title: Stack(
              children: [
                Text(title, style: mainStyle, textAlign: TextAlign.center),
                Text(title,
                    style: mainStyleStroke, textAlign: TextAlign.center),
              ],
            ),
            centerTitle: true,
            toolbarHeight: appBarHeight,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              containerRoutine,
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 25, bottom: 25),
                  side: const BorderSide(width: 6), //adds border
                  primary: Colors.lightBlue,
                ),
                child: Stack(
                  children: <Widget>[
                    Text(
                      'LETS DO IT',
                      style: secStyle,
                    ),
                    Text(
                      'LETS DO IT',
                      style: secStyleStroke,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //contains list of cards for the week
  Widget containerRoutine = Container(
    constraints: const BoxConstraints(minHeight: 475),
    color: Colors.blue,
    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 15,
            ),
            child: Stack(
              children: <Widget>[
                Text('Week 1', style: secStyle),
                Text('Week 1', style: secStyleStroke),
              ],
            )),
      ],
    ),
  );
}
