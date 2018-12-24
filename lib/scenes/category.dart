import 'package:flutter/material.dart';
import 'package:restaurant_manage/common/meDrawer.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = "/categories";

  CategoryScreenState createState() => new CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Category screen")
        )
      ),
      endDrawer: MeDrawer(),
    );
  }
}