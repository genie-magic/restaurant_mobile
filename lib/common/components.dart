import 'package:flutter/material.dart';

class MyTextStyle {
  static textStyle() {
    return TextStyle(
        fontSize: 28.0,
        fontFamily: 'VIP Hala',
        shadows: [
          Shadow( // bottomLeft
              offset: Offset(-2.5, -2.5),
              color: Colors.white
          ),
          Shadow( // bottomRight
              offset: Offset(2.5, -2.5),
              color: Colors.white
          ),
          Shadow( // topRight
              offset: Offset(2.5, 2.5),
              color: Colors.white
          ),
          Shadow( // topLeft
              offset: Offset(-2.5, 2.5),
              color: Colors.white
          )
        ]
    );
  }
}