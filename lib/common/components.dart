import 'package:flutter/material.dart';

class MyTextStyle {
  static textStyle({double fontSize = 28.0, double shadowOffset = 4.5, double blurRadius = 15.0}) {
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
              blurRadius: blurRadius,
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

    // Fades between routes. (If you don't want any animation,
    // just return child.)
    /*return FadeTransition(
      opacity: new Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Interval(
            0.00,
            0.50,
            curve: Curves.linear,
          ),
        ),
      ),
      child: FadeTransition(
        opacity: new Tween<double>(begin: 0.0, end: 1.0).animate(animation),
        child: child,
      ),
    );
    */
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0),
        end: Offset.zero
      ).animate(animation),
      child: child,
    );
  }
}