import 'package:flutter/material.dart';

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

    ListTile getNavItem(var icon, String s, String routeName) {
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
                Navigator.of(context).pushNamed(routeName);
              }
            });
          }
      );
    }

    var myNavChildren =[
      headerChild,
      getNavItem(Icons.home, "Home", "/"),
      getNavItem(Icons.restaurant, "Restaurants", "/restaurants")
    ];

    return Drawer(
        child: ListView(
          children: myNavChildren,
        )
    );
  }
}