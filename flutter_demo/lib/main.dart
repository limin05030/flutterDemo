import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'MainPage.dart';
import 'PermissionDemo.dart';

void main() {
//  runApp(PermissionDemo());
  runApp(MyApp());

  if (Platform.isAndroid) {
    // 以下两行设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，
    // 写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 不显示右上角的debug图标
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _WelcomePage(),
    );
  }
}

class _WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<_WelcomePage> {
  Timer _timer;

  void gotoMainPage(BuildContext context) {
    Navigator.of(context)
        .pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => new MainPage()), (route) => route == null);
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(milliseconds: 3000), () {
      gotoMainPage(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              "images/icon_about_appname.png",
              width: 200,
              height: 200,
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Copyright © GoFindMe,Inc. All rights reserved.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Color.fromARGB(0xFF, 0xC1, 0xC8, 0xD6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
