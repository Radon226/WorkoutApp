import 'package:flutter/material.dart';
import 'routinePage.dart';
import 'package:radons_workout_app/essentials/textTool.dart';

class HomePage extends StatefulWidget {
  @override
  static TextTool textTool = TextTool();
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String title = 'THE \nWORKOUT';

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
              title: HomePage.textTool.writeText1(title, true),
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
                  child: HomePage.textTool.writeText1('START', false),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RoutinePage()));
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
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: HomePage.textTool.writeText2('STREAK', false)),
          const Placeholder(
            fallbackHeight: 170,
            fallbackWidth: 100,
          )
        ],
      ),
    ),
  );

  static String placeholderQuote =
      "You just wait. I'm going to be the biggest Chinese Star in the world. - Bruce Lee";

  Widget quote = Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      constraints: const BoxConstraints(
          maxHeight: 110), //constraints container to max height
      color: primary,
      child: HomePage.textTool.writeText3(placeholderQuote, false));
}
