import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Import components
import 'package:restaurant_manage/all_translations.dart';

// Import Screens
import 'package:restaurant_manage/scenes/aboutus.dart';

class MeDrawer extends StatefulWidget {
  @override
  MeDrawerState createState() => MeDrawerState();
}

class MeDrawerState extends State<MeDrawer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var headerChild = DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: DecorationImage(image: AssetImage("assets/images/logo.png"))
      ),
      child: Container(),
    );

    ListTile getNavItem(var icon, String s, {String routeName, Function handleTap}) {
      return new ListTile(
          leading: Icon(icon),
          title: Text(s,
          style: TextStyle(
              fontFamily: "JF Flat",
            fontSize: 19
          ),),
          onTap: () {
            setState(() {
              // pop closes the drawer
              Navigator.of(context).pop();
              // navigate to the route
              if (routeName == '/') {
                Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
              } else {
                if (handleTap != null) {
                  handleTap();
                  return;
                }
                Navigator.of(context).pushNamed(routeName);
              }
            });
          }
      );
    }

    var myNavChildren =[
      headerChild,
      getNavItem(Icons.home, allTranslations.text('Home'), routeName: "/"),
      getNavItem(Icons.info, allTranslations.text("About Us"), handleTap: () {
        Navigator.push(
          context,
            CupertinoPageRoute (
            builder: (context) => AboutUs()
          )
        );
      }),
    ];

    return Drawer(
        child: ListView(
          children: myNavChildren,
        )
    );
  }
}