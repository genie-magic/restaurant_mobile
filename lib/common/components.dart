import 'package:flutter/material.dart';

class MyTextStyle {
  static textStyle({double fontSize = 28.0, double shadowOffset = 3.5, double blurRadius = 10.0}) {
    return TextStyle(
        fontSize: fontSize,
        fontFamily: 'VIP Hala',
        color: Color(0xff183b4e),
        shadows: [
          Shadow( // bottomLeft
              offset: Offset(-1 * shadowOffset, -1 * shadowOffset),
              color: Colors.white,
              blurRadius: blurRadius
          ),
          Shadow( // bottomRight
              offset: Offset(shadowOffset, -1 * shadowOffset),
              color: Colors.white,
              blurRadius: blurRadius
          ),
          Shadow( // topRight
              offset: Offset(shadowOffset, shadowOffset),
              color: Colors.white,
              blurRadius: blurRadius
          ),
          Shadow( // topLeft
              offset: Offset(-1 * shadowOffset, shadowOffset),
              color: Colors.white,
              blurRadius: blurRadius
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

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (settings.isInitialRoute)
      return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}