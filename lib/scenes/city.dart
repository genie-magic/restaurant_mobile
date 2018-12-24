import 'package:flutter/material.dart';
import 'package:restaurant_manage/common/meDrawer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CityScreen extends StatefulWidget {
  @override
  CityScreenState createState() => new CityScreenState();
}

class CityScreenState extends State<CityScreen> {
  final String url = 'http://localhost:8000/api/cities';

  List<City> cityItems;

  Future<City> getCityData() async {
    var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState((){
      var response = json.decode(res.body);
      var itemList = response['data'].map((val) => City.fromJsonMap(val)).toList();
      cityItems = List<City>.from(itemList);
    });
  }

  Widget _makeElement(int index) {
    if (index >= cityItems.length) {
      return null;
    }

    // print(cityItems[index].image_url);
    print('http://localhost:8000${cityItems[index].image_url}');
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Image.network('http://localhost:8000${cityItems[index].image_url}'),
          Text(cityItems[index].name)
        ],
      )
    );
  }

  @override
  void initState() {
    super.initState();
    this.getCityData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar (
        title: new Text("Navigation Drawer example")
      ),
      body: Center(
        child: ListView.builder(
          itemCount: cityItems == null ? 0 : cityItems.length,
          itemBuilder: (BuildContext context, int index) => _makeElement(index),
        )
      ),
      endDrawer: MeDrawer(),
    );
  }
}

class City {
  final String name;
  final String image_url;

  City.fromJsonMap(Map map)
    : name = map['name'],
      image_url = map['image_url'];
}