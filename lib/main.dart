import 'package:flutter/material.dart';
import 'pages/homePage.dart';
import 'pages/historyPage.dart';
import 'pages/workoutPage.dart';
import 'pages/routinePage.dart';

void main() {
  runApp(MaterialApp(
    home: PageNavigator(),
  ));
}

//for the bottom navigation bar
class PageNavigator extends StatefulWidget {
  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  void initState() {
    super.initState();
  }

  static Color primary = Color.fromARGB(255, 178, 255, 241);

  int _currentIndex = 0;
  static List<Widget> _widgetPages = <Widget>[
    HomePage(),
    Center(child: Text('history')),
    Center(child: Text('settings')),
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _currentIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetPages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primary,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue, //colors not changing bro
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_timeline_outlined),
            label: 'History',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
