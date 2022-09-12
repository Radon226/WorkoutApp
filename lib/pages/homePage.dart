import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static TextStyle mainStyleStroke = TextStyle(
    fontSize: 65,
    fontFamily: 'AnnieUseYourTelescope',
    height: 1.1,
    letterSpacing: 6,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Colors.black,
  );

  static TextStyle mainStyle = const TextStyle(
    fontSize: 65,
    fontFamily: 'AnnieUseYourTelescope',
    height: 1.1,
    letterSpacing: 6,
    color: Colors.black,
  );

  static TextStyle secStyleStroke = TextStyle(
    fontSize: 20,
    fontFamily: 'AnnieUseYourTelescope',
    height: 1.1,
    letterSpacing: 6,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.black,
  );

  static TextStyle secStyle = const TextStyle(
    fontSize: 20,
    fontFamily: 'AnnieUseYourTelescope',
    height: 1.1,
    letterSpacing: 6,
    color: Colors.black,
  );

  static String title = 'THE \n WORKOUT';

  static Color primary = Color.fromARGB(255, 178, 255, 241);
  static Color secondary = Color.fromARGB(255, 231, 255, 254);

  static bool _clicked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        //backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Center(
          child: Column(
            children: [
              titleSection,
              const SizedBox(height: 30),
              streakSection,
              const SizedBox(height: 30),
              startButton,
              const SizedBox(height: 30),
              quote,
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: primary,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_timeline_outlined),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget titleSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      SafeArea(
        child: Container(
          color: primary,
          child: Center(
            child: Stack(
              children: [
                Text(title, style: mainStyle, textAlign: TextAlign.center),
                Text(title,
                    style: mainStyleStroke, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    ],
  );

  Widget streakSection = Container(
    margin: const EdgeInsets.only(left: 30, right: 30),
    color: primary,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 10),
          child: Stack(
            children: <Widget>[
              Text('Streak:', style: mainStyle, textAlign: TextAlign.center),
              Text('Streak:',
                  style: mainStyleStroke, textAlign: TextAlign.center),
            ],
          ),
        ),
        const Placeholder(
          fallbackHeight: 170,
          fallbackWidth: 100,
        )
      ],
    ),
  );

  Widget startButton = ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
      side: const BorderSide(width: 6), //adds border
      primary: secondary,
    ),
    child: Stack(children: <Widget>[
      Text(
        'START',
        style: mainStyle,
      ),
      Text(
        'START',
        style: mainStyleStroke,
      ),
    ]),
  );

  static String placeholderQuote =
      "You just wait. I'm going to be the biggest Chineeeeeeeeeeeeeeeeeese Star in the world. - Bruce Leeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee";

  static String placeHolderQuote1 = "hello";

  Widget quote = Container(
    margin: const EdgeInsets.only(left: 30, right: 30),
    constraints: const BoxConstraints(
        maxHeight: 110), //constraints container to max height
    color: primary,
    child: Stack(children: <Widget>[
      Text(
        placeholderQuote,
        style: secStyle,
        textAlign: TextAlign.center,
      ),
      Text(
        placeholderQuote,
        style: secStyleStroke,
        textAlign: TextAlign.center,
      ),
    ]),
  );
}
