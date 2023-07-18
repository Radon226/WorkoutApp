import 'package:flutter/material.dart';

//contains theme
class ThemeTool {
  final double _appBarHeight = 100;

  final Color _backgroundColor = Color.fromARGB(255, 255, 249, 78); //main background
  final Color _primaryColor = Colors.lightBlueAccent; //for appbar and container
  final Color _secondaryColor = Color.fromARGB(255, 125, 214, 255); //buttons and small interactable widgets

  final TextStyle _strTitle = TextStyle(
    fontSize: 65,
    fontFamily: 'AnnieUseYourTelescope',
    height: .8,
    letterSpacing: 6,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Colors.black,
  );

  final TextStyle _title = const TextStyle(
    fontSize: 65,
    fontFamily: 'AnnieUseYourTelescope',
    height: .8,
    letterSpacing: 6,
    color: Colors.black,
  );

  final TextStyle _strSubtitle = TextStyle(
    fontSize: 48,
    fontFamily: 'AnnieUseYourTelescope',
    height: 1.1,
    letterSpacing: 6,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.black,
  );

  final TextStyle _subtitle = const TextStyle(
    fontSize: 48,
    fontFamily: 'AnnieUseYourTelescope',
    height: 1.1,
    letterSpacing: 6,
    color: Colors.black,
  );

  final TextStyle _strNorm = TextStyle(
    fontSize: 30,
    fontFamily: 'AnnieUseYourTelescope',
    height: .82,
    letterSpacing: 6,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.black,
  );

  final TextStyle _norm = const TextStyle(
    fontSize: 30,
    fontFamily: 'AnnieUseYourTelescope',
    height: .82,
    letterSpacing: 6,
    color: Colors.black,
  );

  final TextStyle _strSmall = TextStyle(
    fontSize: 14,
    fontFamily: 'AnnieUseYourTelescope',
    height: 1.1,
    letterSpacing: 6,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.black,
  );

  final TextStyle _small = const TextStyle(
    fontSize: 14,
    fontFamily: 'AnnieUseYourTelescope',
    height: 1.1,
    letterSpacing: 6,
    color: Colors.black,
  );

  double getAppbarHeight() {
    return _appBarHeight;
  }

  Widget writeTitle(String text, bool center) {
    if (!center) {
      return Stack(
        children: [Text(text, style: _title), Text(text, style: _strTitle)],
      );
    } else {
      return Stack(children: [
        Text(text, style: _title, textAlign: TextAlign.center),
        Text(
          text,
          style: _strTitle,
          textAlign: TextAlign.center,
        )
      ]);
    }
  }

  Widget writeSubtitle(String text, bool center) {
    if (!center) {
      return Stack(
        children: [
          Text(text, style: _subtitle),
          Text(text, style: _strSubtitle)
        ],
      );
    } else {
      return Stack(children: [
        Text(text, style: _subtitle, textAlign: TextAlign.center),
        Text(
          text,
          style: _strSubtitle,
          textAlign: TextAlign.center,
        )
      ]);
    }
  }

  Widget writeNorm(String text, bool center) {
    if (!center) {
      return Stack(
        children: [
          Text(
            text,
            style: _norm,
          ),
          Text(text, style: _strNorm)
        ],
      );
    } else {
      return Stack(children: [
        Text(text, style: _norm, textAlign: TextAlign.center),
        Text(
          text,
          style: _strNorm,
          textAlign: TextAlign.center,
        )
      ]);
    }
  }

  Widget writeSmall(String text, bool center) {
    if (!center) {
      return Stack(
        children: [
          Text(
            text,
            style: _small,
          ),
          Text(text, style: _strSmall)
        ],
      );
    } else {
      return Stack(children: [
        Text(text, style: _small, textAlign: TextAlign.center),
        Text(
          text,
          style: _strSmall,
          textAlign: TextAlign.center,
        )
      ]);
    }
  }

  Color getBackground() {
    return _backgroundColor;
  }

  Color getPrimary() {
    return _primaryColor;
  }

  Color getSecondary() {
    return _secondaryColor;
  }
}
