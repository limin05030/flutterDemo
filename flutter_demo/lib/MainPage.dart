import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'CustomBottomTabBar.dart';
import 'CustomBottomTabBarItem.dart';
import 'map/MapPage.dart';
import 'message/MessagePage.dart';
import 'setting/SettingPage.dart';
import 'share/SharePage.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _MainPageWidget(),
    );
  }
}

class _MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPagState();
}

class MainPagState extends State<_MainPageWidget> with SingleTickerProviderStateMixin {
  static MainPagState _mainPagState;

  static void jumpToPage(int index) {
    if (_mainPagState != null) {
      _mainPagState._jumpToPage(index);
    }
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
//        backgroundColor: Colors.red,
//        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  TabController _tabController;
  PageController _controller;
  int _tabIndex = 0;
  var tabImages;
  List<Widget> _pageList;
  int badgeNo = 105;
  Widget _body;

  void initState() {
    _mainPagState = this;
    super.initState();
    tabImages = [
      [getImage("images/tabar_maps_normal.png"), getImage("images/tabar_maps_selected.png")],
      [getImage("images/tabar_chat_normal.png"), getImage("images/tabar_chat_selected.png")],
      [getImage("images/tabar_share_normal.png"), getImage("images/tabar_share_selected.png")],
      [getImage("images/tabar_setting_normal.png"), getImage("images/tabar_setting_selected.png")]
    ];

    _pageList = [MapPage(), MessagePage(), SharePage(), SettingPage()];

    _tabIndex = 0;
    _tabController = TabController(
      vsync: this,
      initialIndex: _tabIndex,
      length: _pageList.length,
    );
    _controller = PageController(initialPage: _tabIndex);
  }

  Image getImage(String path) {
    return Image.asset(
      path,
      width: 24.0,
      height: 24.0,
    );
  }

  Image getTabIcon(int index) {
    if (_tabIndex == index) {
      return tabImages[index][1];
    } else {
      return tabImages[index][0];
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: _createBody(),
    );
  }

  Widget _createBody() {
    _body = Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        //viewPage禁止左右滑动
        onPageChanged: (index) {
          if (index != _tabIndex) {
            setState(() {
              _tabIndex = index;
            });
          }
        },
        controller: _controller,
        itemCount: _pageList.length,
        itemBuilder: (context, index) => _pageList[index],
      ),
      bottomNavigationBar: BottomTabBar(
        items: <BottomTabBarItem>[
          BottomTabBarItem(
            icon: getTabIcon(0),
            title: Container(),
          ),
          BottomTabBarItem(
            icon: getTabIcon(1),
            title: Container(),
            badgeNo: badgeNo,
          ),
          BottomTabBarItem(
            icon: getTabIcon(2),
            title: Container(),
          ),
          BottomTabBarItem(
            icon: getTabIcon(3),
            title: Container(),
          ),
        ],
        type: BottomTabBarType.fixed,
        currentIndex: _tabIndex,
        badgeColor: Colors.red,
        iconSize: 24.0,
        onTap: _jumpToPage,
      ),
    );

    return _body;
  }

  void _jumpToPage(int index) {
    if (index == 1) {
      badgeNo = 0;
    } else {
      if (badgeNo == 0) {
        badgeNo = Random().nextInt(200);
      }
    }
    _controller.jumpToPage(index);
  }
}
