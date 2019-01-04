import 'package:flutter/material.dart';
import 'all_translations.dart';

// Import scenes
import 'package:restaurant_manage/scenes/city.dart';

void main() async {
  // Initializes the translation module
  await allTranslations.init();

  // then start the application
  runApp(MyApp());
}

const MaterialColor myColor = const MaterialColor (
  0xFF46a2b7,
  const <int, Color> {
    50: const Color(0xFF46a2b7),
    100: const Color(0xFF46a2b7),
    200: const Color(0xFF46a2b7),
    300: const Color(0xFF46a2b7),
    400: const Color(0xFF46a2b7),
    500: const Color(0xFF46a2b7),
    600: const Color(0xFF46a2b7),
    700: const Color(0xFF46a2b7),
    800: const Color(0xFF46a2b7),
    900: const Color(0xFF46a2b7),
  }
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: myColor,
        accentColor: Colors.white,
        fontFamily: 'JF Flat',
        primaryTextTheme: TextTheme(
          body1: TextStyle(
            color: Color(0xff183b4e)
          ),
          body2: TextStyle(
            color: Color(0xff183b4e)
          ),
          title: TextStyle(
            color: Colors.white
          ),
          headline: TextStyle(
            color: Colors.white
          ),
          subhead: TextStyle(
            color: Color(0xff183b4e),
          ),
          caption: TextStyle(
            color: Color(0xff183b4e),
          ),
          display1: TextStyle(
            color: Color(0xff183b4e),
          ),
          display2: TextStyle(
            color: Color(0xff183b4e),
          ),
          display3: TextStyle(
            color: Color(0xff183b4e),
          ),
          display4: TextStyle(
            color: Color(0xff183b4e),
          ),
          overline: TextStyle(
            color: Color(0xff183b4e),
          ),
          subtitle: TextStyle(
            color: Color(0xff183b4e),
          )
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.white
        )
      ),
      home: CityScreen()
    );
  }
}