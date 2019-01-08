import 'package:flutter/material.dart';
import 'dart:async';

/// Import scenes
import 'package:restaurant_manage/scenes/city.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => CityScreen()
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: const BoxDecoration(
        image: const DecorationImage(
          fit: BoxFit.fill,
          image: const AssetImage("assets/images/splash.jpg")
        )
      ),
      child: Container(),
    );
  }
  
  @override
  void initState() {
    super.initState();
    startTime();
  }
}