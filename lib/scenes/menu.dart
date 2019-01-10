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
import 'package:restaurant_manage/common/my_photo_view/lib/photo_view_gallery.dart';

// Import settings
import 'package:restaurant_manage/settings.dart';

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
  final String url = '${MySettings.API_BASE_URL}/api/menus';
  String searchQuery;
  List<Menu> menuLists;

  Future<Menu> getMenuData() async {
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

  _makeItemGallery(int menuIndex) {
    List<PhotoViewGalleryPageOptions> options;

    options = List<PhotoViewGalleryPageOptions>.from(
      menuLists[menuIndex].items.map((f) => PhotoViewGalleryPageOptions(
        imageProvider:
          f.image_url != null?
          NetworkImage('${MySettings.API_BASE_URL}${f.image_url}'):
          AssetImage("assets/images/logo.png"),
        itemLabel: f.name,
        itemPrice: f.price,
      )).toList()
    );

    return options;
  }

  _showItemDialog(int menuIndex, int itemIndex) {
    // String price = (int.parse(item.price.toString()) / 100).toString();
    var _pageController = new PageController(initialPage: itemIndex);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54
              ),
              padding: EdgeInsets.only(top: 40, bottom: 40),
              child: new Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: PhotoViewGallery(
                      pageController: _pageController,
                      pageOptions: _makeItemGallery(menuIndex),
                      backgroundDecoration: BoxDecoration(
                          color: Colors.transparent
                      )
                  ),
                ),
              )
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        );
      }
    );
  }

  Widget _renderMenu(int ind) {
    if (ind == 0) {
      return AspectRatio(
        aspectRatio: 4/2,
        child: Container(
            margin: EdgeInsets.fromLTRB(10.0, 15.5, 10.0, 2.5),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        '${MySettings.API_BASE_URL}${widget.restaurantImage}'
                    ),
                    colorFilter: ColorFilter.mode(Colors.black.withBlue(10).withOpacity(0.6), BlendMode.darken)
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
      );
    }
    int index = ind - 1;
    if (index >= menuLists.length) {
      return null;
    }

    return custom.ExpansionTile(
      title: Text(
          menuLists[index].name,
      ),
      headerBackgroundColor: Colors.white,
      headerBackgroundColorExpanded: Theme.of(context).primaryColor,
      children: menuLists[index].items.map((f) =>_renderMenuItem(f, index)).toList()
    );
  }

  Widget _renderMenuItem(Item item, int menuIndex) {
    var itemIndex = menuLists[menuIndex].items.indexOf(item);
    String price = (int.parse(item.price.toString()) ~/ 100).toString();
    return Container(
      margin: EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
      child: GestureDetector(
        onTap: () {
          _showItemDialog(menuIndex, itemIndex);
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
                        image: NetworkImage('${MySettings.API_BASE_URL}${item.image_url}')
                    )
                ),
              ),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      item.name,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  )
              ),
              Column(
                children: <Widget>[
                  Text(
                    allTranslations.text("Price"),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                          price,
                          style: TextStyle(color: Theme.of(context).primaryTextTheme.body1.color)
                      ),
                      Text(
                        ' ' + allTranslations.text("rial"),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
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
            Expanded(
              child: ListView.builder(
                itemCount: menuLists == null ? 1 : menuLists.length + 1,
                itemBuilder: (BuildContext context, int index) => _renderMenu(index),
              ),
            )
          ],
        ),
        drawer: MeDrawer(),
        backgroundColor: Color(0xffe8e8e8),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (menuLists != null) {
      menuLists.clear();
    }
    super.dispose();
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
  final int price;

  Item.fromJsonMap(Map map)
    : name = map['name'],
      image_url = map['image_url'],
      id = map['id'].toString(),
      price = map['price'];
}