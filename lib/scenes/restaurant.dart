import 'package:flutter/material.dart';
import 'package:restaurant_manage/common/meDrawer.dart';

class RestaurantScreen extends StatefulWidget {
  static const String routeName = "/restaurants";

  RestaurantScreenState createState() => new RestaurantScreenState();
}

class RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("Navigation Drawer here")
      ),
      body: Container(
        child: Center(
          child: Text("Restaurant screen")
        )
      ),
      endDrawer: MeDrawer(),
    );
  }
}