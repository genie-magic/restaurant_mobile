import 'package:flutter/material.dart';
import 'package:restaurant_manage/common/meDrawer.dart';

class CityScreen extends StatefulWidget {
  @override
  CityScreenState createState() => new CityScreenState();
}

class CityScreenState extends State<CityScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar (
        title: new Text("Navigation Drawer example")
      ),
      body: Container(
        child: Center(
          child: Text("Home screen"),
        )
      ),
      endDrawer: MeDrawer(),
    );
  }
}