import 'package:flutter/material.dart';

class Header extends AppBar {
  Header(
      {Key key,
      VoidCallback leadingAction,
      String leadingIconPath = "images/icon_nav_back.png",
      String title,
      bool centerTitle = true,
      List<Widget> actions,
      Color backgroundColor = Colors.white,
      double elevation = 0.0,
      Brightness brightness = Brightness.light})
      : assert(leadingAction == null || (leadingIconPath != null && leadingIconPath.isNotEmpty)),
        super(
          key: key,
          leading: _createLeading(leadingAction, leadingIconPath),
          title: _createTitle(title),
          centerTitle: centerTitle,
          actions: actions,
          elevation: elevation,
          backgroundColor: backgroundColor,
          brightness: brightness,
        );

  static Widget _createLeading(VoidCallback leadingAction, String leadingIconPath) {
    if (leadingAction == null || leadingIconPath == null) {
      return null;
    } else {
      return Container(
        margin: EdgeInsets.all(8),
        child: InkWell(
          onTap: leadingAction,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Image.asset(
              leadingIconPath,
              width: 24.0,
              height: 24.0,
            ),
          ),
        ),
      );
    }
  }

  static Widget _createTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF333333),
      ),
    );
  }
}
