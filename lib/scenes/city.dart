import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Import components
import 'package:restaurant_manage/common/components.dart';
import 'package:restaurant_manage/common/meDrawer.dart';
import 'package:restaurant_manage/all_translations.dart';
import 'package:restaurant_manage/common/searchAppbar.dart';

// Import screens
import 'package:restaurant_manage/scenes/category.dart';

//  Import settings
import 'package:restaurant_manage/settings.dart';

class CityScreen extends StatefulWidget {
  @override
  CityScreenState createState() => new CityScreenState();
}

class CityScreenState extends State<CityScreen> {
  final String url = '${MySettings.API_BASE_URL}/api/cities';
  String searchQuery = '';

  List<City> cityItems;
  int activeIndex = -1;

  Future<City> getCityData() async {
    var res = await http.get(Uri.encodeFull(url + '?' + searchQuery), headers: {"Accept": "application/json"});

    setState((){
      var response = json.decode(res.body);
      var itemList = response['data'].map((val) => City.fromJsonMap(val)).toList();
      cityItems = List<City>.from(itemList);
    });
  }

  void onTextChange(String text) {
    searchQuery = 'city_name=$text';
    getCityData();
  }

  Widget _makeElement(int index) {
    if (index >= cityItems.length) {
      return null;
    }
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          activeIndex = index;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          activeIndex = -1;
        });
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryScreen (cityId: cityItems[index].id),
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
              color: Colors.cyan.withOpacity(0.8),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  '${MySettings.API_BASE_URL}${cityItems[index].image_url}',
                ),
                colorFilter: ColorFilter.mode(Colors.cyan.withOpacity(0.2), BlendMode.dstATop)
              ),
              boxShadow: MyBoxShadow.boxShadow()
            ),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  cityItems[index].name,
                  style: MyTextStyle.textStyle(),
                )
            )
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    searchQuery = '';
    this.getCityData();
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
            title: allTranslations.text('Cities'),
            bShowBackBtn: false,
          ),
          preferredSize: const Size.fromHeight(kToolbarHeight)
        ),
        body: Container(
            margin: EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemCount: cityItems == null ? 0 : cityItems.length,
              itemBuilder: (BuildContext context, int index) => _makeElement(index),
            )
        ),
        drawer: MeDrawer(),
        backgroundColor: Color(0xffe8e8e8),
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cityItems.clear();
  }
}

class City {
  final String name;
  final String image_url;
  final String id;

  City.fromJsonMap(Map map)
    : name = map['name'],
      image_url = map['image_url'],
      id = map['id'].toString();
}