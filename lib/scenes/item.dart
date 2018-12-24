import 'package:flutter/material.dart';
import 'package:restaurant_manage/common/meDrawer.dart';

class ItemScreen extends StatefulWidget {
  static const String routeName = "/items";

  ItemScreenState createState() => new ItemScreenState();
}

class ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Item screen")
        )
      ),
      endDrawer: MeDrawer()
    );
  }
}