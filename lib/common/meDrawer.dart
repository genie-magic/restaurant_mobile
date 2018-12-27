import 'package:flutter/material.dart';

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
      child: Image.asset(
          "images/logo.png"
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.lightBlue,
            Colors.blueAccent
        ])
      )
    );

    const aboutChild = AboutListTile(
      child: Text("About"),
      applicationName: "Restaurant Manage",
      applicationVersion: "v1.0.0",
      applicationIcon: Icon(Icons.adb),
    );

    ListTile getNavItem(var icon, String s, {String routeName, Function handleTap}) {
      return new ListTile(
          leading: Icon(icon),
          title: Text(s),
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
          MaterialPageRoute(
            builder: (context) => AboutUs()
          )
        );
      }),
      aboutChild
    ];

    return Drawer(
        child: ListView(
          children: myNavChildren,
        )
    );
  }
}