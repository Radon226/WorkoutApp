import 'package:flutter/material.dart';

class TextTool {
  TextStyle styleStroke1 = TextStyle(
    fontSize: 65,
    fontFamily: 'AnnieUseYourTelescope',
    height: .8,
    letterSpacing: 6,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Colors.black,
  );

  TextStyle style1 = const TextStyle(
    fontSize: 65,
    fontFamily: 'AnnieUseYourTelescope',
    height: .8,
    letterSpacing: 6,
    color: Colors.black,
  );

  TextStyle styleStroke2 = TextStyle(
    fontSize: 30,
    fontFamily: 'AnnieUseYourTelescope',
    height: .82,
    letterSpacing: 6,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.black,
  );

  TextStyle style2 = const TextStyle(
    fontSize: 30,
    fontFamily: 'AnnieUseYourTelescope',
    height: .82,
    letterSpacing: 6,
    color: Colors.black,
  );

  TextStyle styleStroke3 = TextStyle(
    fontSize: 14,
    fontFamily: 'AnnieUseYourTelescope',
    height: 1.1,
    letterSpacing: 6,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.black,
  );

  TextStyle style3 = const TextStyle(
    fontSize: 14,
    fontFamily: 'AnnieUseYourTelescope',
    height: 1.1,
    letterSpacing: 6,
    color: Colors.black,
  );

  Widget writeText1(String text, bool center) {
    if (!center) {
      return Stack(
        children: [Text(text, style: style1), Text(text, style: styleStroke1)],
      );
    } else {
      return Stack(children: [
        Text(text, style: style1, textAlign: TextAlign.center),
        Text(
          text,
          style: styleStroke1,
          textAlign: TextAlign.center,
        )
      ]);
    }
  }

  Widget writeText2(String text, bool center) {
    if (!center) {
      return Stack(
        children: [Text(text, style: style2), Text(text, style: styleStroke2)],
      );
    } else {
      return Stack(children: [
        Text(text, style: style2, textAlign: TextAlign.center),
        Text(
          text,
          style: styleStroke2,
          textAlign: TextAlign.center,
        )
      ]);
    }
  }

  Widget writeText3(String text, bool center) {
    if (!center) {
      return Stack(
        children: [
          Text(
            text,
            style: style3,
          ),
          Text(text, style: styleStroke3)
        ],
      );
    } else {
      return Stack(children: [
        Text(text, style: style3, textAlign: TextAlign.center),
        Text(
          text,
          style: styleStroke3,
          textAlign: TextAlign.center,
        )
      ]);
    }
  }
}
