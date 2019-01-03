import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Import screens
import 'package:restaurant_manage/scenes/menu.dart';
// Import components
import 'package:restaurant_manage/common/meDrawer.dart';
import 'package:restaurant_manage/common/searchAppbar.dart';
import 'package:restaurant_manage/all_translations.dart';
import 'package:restaurant_manage/common/components.dart';
import 'package:restaurant_manage/settings.dart';

class RestaurantScreen extends StatefulWidget {
  final String categoryId;

  RestaurantScreen({Key key, @required this.categoryId}) : super(key: key);

  RestaurantScreenState createState() => new RestaurantScreenState();
}

class RestaurantScreenState extends State<RestaurantScreen> {
  final String url = '${MySettings.API_BASE_URL}/api/restaurants';
  String searchQuery;
  List<Restaurant> restaurantItems;

  Future<Restaurant> getRestaurantData() async {
    var res = await http.get(Uri.encodeFull('$url?category=${widget.categoryId}&restaurant_name=$searchQuery'), headers: {"Accept": "application/json"});

    setState(() {
      var response = json.decode(res.body);
      restaurantItems = List<Restaurant>.from(response['data'].map((val) => Restaurant.fromJsonMap(val)).toList());
    });
  }

  void onTextChange(String text) {
    searchQuery = text;
    getRestaurantData();
  }

  Widget _makeElement(int index) {
    if (index >= restaurantItems.length) {
      return null;
    }

    return GestureDetector(
        onTap: () {
          Navigator.push (
            context,
            MaterialPageRoute(
              builder: (context) => MenuScreen (
                restaurantId: restaurantItems[index].id,
                restaurantTitle: restaurantItems[index].name,
                restaurantImage: restaurantItems[index].image_url,
              )
            )
          );
        },
        child: AspectRatio(
            aspectRatio: 5/2,
            child: Container(
              margin: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        '${MySettings.API_BASE_URL}${restaurantItems[index].image_url}'
                    ),
                  )
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  restaurantItems[index].name,
                  style: MyTextStyle.textStyle()
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
    this.getRestaurantData();
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
              title: allTranslations.text("Restaurant"),
            ),
            preferredSize: const Size.fromHeight(kToolbarHeight)
        ),
        body: Container(
            margin: EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemCount: restaurantItems == null ? 0 : restaurantItems.length,
              itemBuilder: (BuildContext context, int index) => _makeElement(index),
            )
        ),
        drawer: MeDrawer(),
        backgroundColor: Color(0xffe8e8e8),
      ),
    );
  }
}

class Restaurant {
  final String name;
  final String image_url;
  final String id;

  Restaurant.fromJsonMap(Map map)
    : name = map['name'],
      image_url = map['image_url'],
      id = map['id'].toString();
}