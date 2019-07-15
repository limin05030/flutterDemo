import 'package:flutter/material.dart';
import 'package:flutter_app/map/MapManagementPage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AboutPage.dart';
import 'AdvancedSettingPage.dart';
import 'DevicePage.dart';
import 'FeedbackPage.dart';
import 'GeneralSettingPage.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with AutomaticKeepAliveClientMixin {
  static const List itemData = [
    ["images/setting_icon_general.png", "Genernal Setting", 1],
    ["images/setting_icon_advanced.png", "Advanced Setting", 1],
    ["images/setting_icon_connect.png", "Device Connection", 1],
    ["images/setting_icon_map.png", "Map Management", 1],
    ["", "", 0],
    ["images/setting_icon_feedback.png", "Feedback", 1],
    ["images/setting_icon_manual.png", "User Manual", 1],
    ["images/setting_icon_about.png", "About", 1],
  ];


  void _onItemTap(int index) {
    Widget page;
    switch (index) {
      case 0:
        page = GeneralSettingPage();
        break;
      case 1:
        page = new AdvancedSettingPage();
        break;
      case 2:
        page = DevicePage();
        break;
      case 3:
        page = MapManagementPage();
        break;
      case 4:
        page = null;
        break;
      case 5:
        page = FeedbackPage();
        break;
      case 6:
        _openWebsite();
        break;
      case 7:
        page = AboutPage();
        break;
    }

    if (page != null) {
      Navigator.push(context, new MaterialPageRoute(builder: (context) => page));
    }
  }

  void _openWebsite() async {
    const url = "http://www.aiblue.com/faq";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GoFindMe',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF333333),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
      ),
      backgroundColor: Color(0xFFF5F7F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 0.5,
            color: Color(0xFFE0E0E0),
          ),
          Container(
            height: 15.0,
            color: Color(0xFFF5F7F9),
          ),
          Container(
            height: 0.5,
            color: Color(0xFFE0E0E0),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemData.length,
              itemBuilder: (BuildContext context, int index) {
                return _createListItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createListItem(int index) {
    if (itemData[index][2] == 0) {
      return Column(
        children: <Widget>[
          Container(
            height: 15,
            color: Color(0xFFF5F7F9),
          ),
          Container(
            height: 0.5,
            color: Color(0xFFE0E0E0),
          ),
        ],
      );
    }

    double lineStartPadding;
    if (index == itemData.length - 1 || itemData[index + 1][2] == 0) {
      lineStartPadding = 0.0;
    } else {
      lineStartPadding = 16.0;
    }

    return Container(
      height: 70.5,
      color: Colors.white,
      child: Material(
        // InkWell 在非透明的背景下是没有水波纹效果的，这个时候需要加一个Material并将color设置为透明
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _onItemTap(index);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 25, 21, 25),
                    child: Image.asset(
                      itemData[index][0],
                      width: 20.0,
                      height: 20.0,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      itemData[index][1],
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 26.0),
                    child: Image.asset(
                      "images/icon_list_next.png",
                      width: 15.0,
                      height: 15.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: lineStartPadding,
                ),
                child: Container(
                  height: 0.5,
                  color: Color(0xFFE0E0E0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
