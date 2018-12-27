import 'package:flutter/material.dart';

class MyTextStyle {
  static textStyle() {
    return TextStyle(
        fontSize: 28.0,
        shadows: [
          Shadow( // bottomLeft
              offset: Offset(-1.5, -1.5),
              color: Colors.white
          ),
          Shadow( // bottomRight
              offset: Offset(1.5, -1.5),
              color: Colors.white
          ),
          Shadow( // topRight
              offset: Offset(1.5, 1.5),
              color: Colors.white
          ),
          Shadow( // topLeft
              offset: Offset(-1.5, 1.5),
              color: Colors.white
          )
        ]
    );
  }
}