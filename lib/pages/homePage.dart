import 'package:flutter/material.dart';
import 'routinePage.dart';
import 'package:radons_workout_app/essentials/themeTool.dart';

class HomePage extends StatefulWidget {
  @override
  static ThemeTool themeTool = ThemeTool();
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String title = 'THE \nWORKOUT';

  static Color background = HomePage.themeTool.getBackground();
  static Color primary = HomePage.themeTool.getPrimary();
  static Color secondary = HomePage.themeTool.getSecondary();

  double appBarHeight = HomePage.themeTool.getAppbarHeight() + 28;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: primary,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: appBarHeight,
        ),
        fontFamily: 'AnnieUsedHerTelescope',
      ),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: HomePage.themeTool.writeTitle(title, true),
            ),
            centerTitle: true,
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
                        left: 25, right: 25, top: 30, bottom: 15),
                    side: const BorderSide(width: 6), //adds border
                    backgroundColor: secondary,
                  ),
                  child: HomePage.themeTool.writeTitle('START', false),
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
    margin: const EdgeInsets.only(left: 20, right: 20),
    //color: secondary,
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: HomePage.themeTool.writeSubtitle('STREAK:', false)),
          const Placeholder(
            fallbackHeight: 170,
            fallbackWidth: 120,
          )
        ],
      ),
    ),
  );

  static String placeholderQuote =
      "You just wait. I'm going to be the biggest Chinese Star in the world.\n\nBruce Lee";

  Widget quote = Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      constraints: const BoxConstraints(
          maxHeight: 110), //constraints container to max height
      //color: secondary,
      child: HomePage.themeTool.writeSmall(placeholderQuote, true));
}
