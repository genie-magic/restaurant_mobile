import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Import components
import 'package:restaurant_manage/all_translations.dart';

// Import Screens
import 'package:restaurant_manage/scenes/aboutus.dart';
import 'package:restaurant_manage/scenes/contactus.dart';

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
                Navigator.popUntil(context,
                    ModalRoute.withName('/home'));
              } else {
                if (handleTap != null) {
                  handleTap();
                  return;
                }
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
      getNavItem(Icons.email, allTranslations.text("Contact Us"), handleTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ContactUs()
          )
        );
      })
    ];

    return Drawer(
        child: ListView(
          children: myNavChildren,
        )
    );
  }
}