import 'package:flutter/material.dart';
import 'package:restaurant_manage/all_translations.dart';
import 'package:validate/validate.dart';

// Import components
import 'package:restaurant_manage/common/meDrawer.dart';

class ContactUs extends StatefulWidget {
  @override
  ContactUsState createState() => new ContactUsState();
}

class ContactUsState extends State<ContactUs> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
        textDirection: allTranslations.textDirection,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(allTranslations.text("Contact Us"),
            ),
            leading: IconButton(
              icon: Icon(Icons.menu, size: 45,),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            centerTitle: true,
            actions: <Widget>[
              BackButton()
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text('c.menu18@gmail.com'),
                )
              ],
            )
          ),
          drawer: MeDrawer(),
          backgroundColor: Color(0xffe8e8e8),
        )
    );
  }
}