import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Import components
import 'package:restaurant_manage/common/meDrawer.dart';
import 'package:restaurant_manage/common/searchAppbar.dart';
import 'package:restaurant_manage/all_translations.dart';

// Import screens
import 'package:restaurant_manage/scenes/restaurant.dart';

class CategoryScreen extends StatefulWidget {
  final String cityId;
  CategoryScreen({Key key, @required this.cityId}) : super(key: key);

  @override
  CategoryScreenState createState() => new CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  final String url = "http://localhost:8000/api/categories";
  List<Category> categoryItems;
  String searchQuery;

  Future<Category> getCategoryData() async {
    var res = await http.get(Uri.encodeFull('$url?city=${widget.cityId}&category_name=$searchQuery'), headers: {"Accept": "application/json"});

    setState((){
      var response = json.decode(res.body);
      categoryItems = List<Category>.from(response['data'].map((val) => Category.fromJsonMap(val)).toList());
    });
  }

  void onTextChange(String text) {
    searchQuery = text;
    getCategoryData();
  }

  Widget _makeElement(int index) {
    if (index >= categoryItems.length) {
      return null;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantScreen (categoryId: categoryItems[index].id)
          )
        );
      },
      child: AspectRatio(
        aspectRatio: 5/2,
        child: Container(
          margin: EdgeInsets.fromLTRB(10.0, 5.5, 10.0, 2.5),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'http://localhost:8000${categoryItems[index].image_url}'
                ),
            )
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              categoryItems[index].name,
              style: TextStyle(
                  fontSize: 28.0,
                  shadows: [
                    Shadow( // bottomLeft
                        offset: Offset(-1.5, -1.5),
                        color: Colors.white
                    ),
                    Shadow( // bottomRight
                        offset: Offset(1.5, -1.5),
                        color: Colors.white
                    ),
                    Shadow( // topRight
                        offset: Offset(1.5, 1.5),
                        color: Colors.white
                    ),
                    Shadow( // topLeft
                        offset: Offset(-1.5, 1.5),
                        color: Colors.white
                    )
                  ]
              ),
            ),
          ),
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    searchQuery = '';
    this.getCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
      textDirection: allTranslations.textDirection,
      child: Scaffold(
        appBar: PreferredSize(
            child: SearchAppBar(
              onTextChange: onTextChange,
              title: "Categories",
            ),
            preferredSize: const Size.fromHeight(kToolbarHeight)
        ),
        body: Container(
            margin: EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemCount: categoryItems == null ? 0 : categoryItems.length,
              itemBuilder: (BuildContext context, int index) => _makeElement(index),
            )
        ),
        drawer: MeDrawer(),
        backgroundColor: Color(0xffe8e8e8),
      ),
    );
  }
}

class Category {
  final String name;
  final String image_url;
  final String id;

  Category.fromJsonMap(Map map)
    : name = map['name'],
      image_url = map['image_url'],
      id = map['id'].toString();
}