import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Import components
import 'package:restaurant_manage/common/meDrawer.dart';
import 'package:restaurant_manage/common/components.dart';
import 'package:restaurant_manage/common/custom_expansion_tile.dart' as custom;
import 'package:restaurant_manage/common/searchAppbar.dart';
import 'package:restaurant_manage/all_translations.dart';

class MenuScreen extends StatefulWidget {
  final String restaurantId;
  final String restaurantTitle;
  final String restaurantImage;

  MenuScreen({
    Key key,
    @required this.restaurantId,
    @required this.restaurantTitle,
    @required this.restaurantImage
  }) : super(key: key);

  @override
  MenuScreenState createState() => new MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  final String url = "http://localhost:8000/api/menus";
  String searchQuery;
  List<Menu> menuLists;

  Future<Menu> getMenuData() async {
    print(Uri.encodeFull('$url?restaurant=${widget.restaurantId}&menu_name=$searchQuery&item_name=$searchQuery'));
    var res = await http.get(Uri.encodeFull('$url?restaurant=${widget.restaurantId}&menu_name=$searchQuery&item_name=$searchQuery'), headers: {"Accept": "application/json"});

    setState(() {
      var response = json.decode(res.body);
        menuLists = List<Menu>.from(
        response['data'].map((val) => Menu.fromJsonMap(val)).toList()
        );
      });
  }

  void onTextChange(String text) {
    searchQuery = text;
    getMenuData();
  }

  _showItemDialog(Item item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 150, bottom: 50),
              child: Container (
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'http://localhost:8000${item.image_url}',
                        ),
                        fit: BoxFit.cover
                    ),
                    color: Colors.transparent
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                        item.name,
                        style: MyTextStyle.textStyle()
                    ),
                    Text(
                        'Price:${item.price}rian',
                        style: MyTextStyle.textStyle()
                    )
                  ],
                ),
              ),
            ),
          )
        );
      }
    );
  }

  Widget _renderMenu(int index) {
    if (index >= menuLists.length) {
      return null;
    }

    return custom.ExpansionTile(
      title: Text(
          menuLists[index].name,
      ),
      headerBackgroundColor: Colors.white,
      headerBackgroundColorExpanded: Colors.cyan,
      children: menuLists[index].items.map((f) =>_renderMenuItem(f)).toList()
    );
  }

  Widget _renderMenuItem(Item item) {
    return GestureDetector(
      onTap: () {
        _showItemDialog(item);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0.0, -5.0),
                color: Color(0xffEDEDED),
                blurRadius: 5.0,
              ),
            ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // textDirection: TextDirection.rtl,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: ShapeDecoration(
                  shape: CircleBorder(side: BorderSide(color: Colors.grey)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('http://localhost:8000${item.image_url}',)
                  )
              ),
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    item.name,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                )
            ),
            Column(
              children: <Widget>[
                Text(
                  "Price",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Row(
                  children: <Widget>[
                    Text(
                        item.price,
                        style: TextStyle(color: Theme.of(context).primaryTextTheme.body1.color)
                    ),
                    Text(
                      ' Rial',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    searchQuery='';
    this.getMenuData();
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
              title: allTranslations.text("Menu"),
            ),
            preferredSize: const Size.fromHeight(kToolbarHeight)
        ),
        body: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 4/2,
              child: Container(
                  margin: EdgeInsets.fromLTRB(10.0, 15.5, 10.0, 2.5),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'http://localhost:8000${widget.restaurantImage}'
                        ),
                      )
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.restaurantTitle,
                        style: MyTextStyle.textStyle(),
                      )
                  )
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(5.0, 2.5, 5.0, 2.5),
                padding: EdgeInsets.all(5.0),
                child: ListView.builder(
                  itemCount: menuLists == null ? 0 : menuLists.length,
                  itemBuilder: (BuildContext context, int index) => _renderMenu(index),
                ),
              ),
            )
          ],
        ),
        drawer: MeDrawer(),
        backgroundColor: Color(0xffe8e8e8),
      ),
    );
  }
}

class Menu {
  final String name;
  final String image_url;
  final String id;
  final List<Item> items;

  Menu.fromJsonMap(Map map)
    : name = map['name'],
      image_url = map['image_url'],
      id = map['id'].toString(),
      items = List<Item>.from(map['items'].map((item) => Item.fromJsonMap(item)).toList());
}

class Item {
  final String name;
  final String image_url;
  final String id;
  final String price;

  Item.fromJsonMap(Map map)
    : name = map['name'],
      image_url = map['image_url'],
      id = map['id'].toString(),
      price = map['price'].toString();
}