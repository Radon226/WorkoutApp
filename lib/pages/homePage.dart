import 'package:flutter/material.dart';
import 'routinePage.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 178, 255, 241),
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 178, 255, 241),
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 165,
        ),
        fontFamily: 'AnnieUsedHerTelescope',
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: AppBar(
              title: Stack(
                children: [
                  Text(title, style: mainStyle, textAlign: TextAlign.center),
                  Text(title,
                      style: mainStyleStroke, textAlign: TextAlign.center),
                ],
              ),
              centerTitle: true,
            ),
          ),
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                streakSection,
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 15, bottom: 15),
                    side: const BorderSide(width: 6), //adds border
                    primary: secondary,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Text(
                        'START',
                        style: mainStyle,
                      ),
                      Text(
                        'START',
                        style: mainStyleStroke,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RoutinePage()));
                  },
                ),
                const SizedBox(height: 30),
                quote,
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  static String placeholderQuote =
      "You just wait. I'm going to be the biggest Chinese Star in the world. - Bruce Lee";

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
