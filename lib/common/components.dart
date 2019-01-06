import 'package:flutter/material.dart';

class MyTextStyle {
  static textStyle({double fontSize = 28.0, double shadowOffset = 1.0}) {
    return TextStyle(
        fontSize: fontSize,
        fontFamily: 'VIP Hala',
        color: Color(0xff183b4e),
        shadows: [
          Shadow( // bottomLeft
              offset: Offset(-1 * shadowOffset, -1 * shadowOffset),
              color: Colors.white
          ),
          Shadow( // bottomRight
              offset: Offset(shadowOffset, -1 * shadowOffset),
              color: Colors.white
          ),
          Shadow( // topRight
              offset: Offset(shadowOffset, shadowOffset),
              color: Colors.white
          ),
          Shadow( // topLeft
              offset: Offset(-1 * shadowOffset, shadowOffset),
              color: Colors.white
          )
        ]
    );
  }
}

class MyBoxShadow {
  static boxShadow() {
    return [
      BoxShadow( // bottomLeft
          offset: Offset(-2.5, -2.5),
          color: Color(0xffe8e8e8)
      ),
      BoxShadow( // bottomRight
          offset: Offset(2.5, -2.5),
          color: Color(0xffe8e8e8)
      ),
      BoxShadow( // topRight
          offset: Offset(2.5, 2.5),
          color: Color(0xffe8e8e8)
      ),
      BoxShadow( // topLeft
          offset: Offset(-2.5, 2.5),
          color: Color(0xffe8e8e8)
      )
    ];
  }
}