import 'package:flutter/material.dart';
import 'package:restaurant_manage/common/meDrawer.dart';

class MenuScreen extends StatefulWidget {
  static const String routeName = "/menus";

  MenuScreenState createState() => new MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Menu screen")
        )
      ),
      endDrawer: MeDrawer(),
    );
  }
}