import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  static const String _title = 'App \n Name';

  HomePage({Key? key}) : super(key: key); //hello

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 207, 197, 140),
        body: Center(
          child: Column(
            children: [
              titleSection,
              streakSection,
            ],
          ),
        ),
      ),
    );
  }

  Widget titleSection = Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
        child: Column(
          children: const [
            Text(_title,
                style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 80, 80, 80)),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    ],
  );

  Widget streakSection = Container(
    margin: const EdgeInsets.only(left: 30, right: 30),
    child: const Placeholder(
      color: Colors.red,
      fallbackHeight: 100,
      fallbackWidth: 20,
    ),
  );
}
