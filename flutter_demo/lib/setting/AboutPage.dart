import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../Header.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _appVersion = "";
  final _buildYear = "2019";
  String _deviceVersion = "2.3.6";

  void _onBackPressed() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      setState(() {
        _appVersion = info.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _onBackPressed();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: Header(
          leadingAction: _onBackPressed,
          title: "About",
        ),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 0.5,
                  color: Color(0xFFE0E0E0),
                ),
                Container(
                  margin: EdgeInsets.only(top: 64),
                  child: Image.asset(
                    "images/icon_about_applogo.png",
                    width: 72,
                    height: 72,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Image.asset(
                    "images/icon_about_appname.png",
                    height: 20,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, bottom: 5),
                  child: Text(
                    "App v$_appVersion Build $_buildYear",
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFC1C8D6),
                    ),
                  ),
                ),
                Text(
                  "Device v$_deviceVersion",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFC1C8D6),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "http://www.gofindme.com",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF5886DC),
                    decoration: TextDecoration.underline,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 23),
                  child: Text(
                    "Copyright © GoFindMe,Inc. All rights reserved.",
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFC1C8D6),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
