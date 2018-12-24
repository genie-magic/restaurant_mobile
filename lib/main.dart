import 'package:flutter/material.dart';
import 'all_translations.dart';

// Import scenes
import 'package:restaurant_manage/scenes/city.dart';
import 'package:restaurant_manage/scenes/category.dart';
import 'package:restaurant_manage/scenes/item.dart';
import 'package:restaurant_manage/scenes/menu.dart';
import 'package:restaurant_manage/scenes/restaurant.dart';

void main() async {
  // Initializes the translation module
  await allTranslations.init();

  // then start the application
  runApp(MyApp());
}

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
        primarySwatch: Colors.indigo,
      ),
      home: CityScreen(),
      routes: <String, WidgetBuilder> {
        CategoryScreen.routeName: (context) => CategoryScreen(),
        ItemScreen.routeName: (context) => ItemScreen(),
        MenuScreen.routeName: (context) => MenuScreen(),
        RestaurantScreen.routeName: (context) => RestaurantScreen()
      },
    );
  }
}