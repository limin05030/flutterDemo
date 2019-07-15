import 'package:flutter/material.dart';

import 'AppSetting.dart';

class GeneralSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GeneralSettingPageState();
}

class _GeneralSettingPageState extends State<GeneralSettingPage> {
   final _itemData = [
    ["Language", ""],
    ["Measure Units", ""],
    ["Message Password", "666666"],
    ["Broascast Mesh", "SOS"],
    ["Switch Region", "China"],
    ["Location Update", "10s"],
  ];

  void _onItemTap(int index) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("click ${_itemData[index][0]}"),
    ));
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    var lanFuture = AppSetting.getInstance().getLanguageId();
    if (lanFuture != null) {
      lanFuture.then((id) {
        setState(() {
          _itemData[0][1] = AppSetting.getInstance().getLanguage(id);
        });
      });
    }

    var unitFuture = AppSetting.getInstance().getMeasureUnitId();
    if (unitFuture != null) {
      unitFuture.then((id) {
        setState(() {
          _itemData[1][1] = AppSetting.getInstance().getSystemUnitName(id);
        });
      });
    }

    var pwdFuture = AppSetting.getInstance().getPassword();
    if (pwdFuture != null) {
      pwdFuture.then((pwd) {
        setState(() {
          _itemData[2][1] = pwd ?? "";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _onBackPressed();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.all(8),
            child: InkWell(
              onTap: _onBackPressed,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Image.asset(
                  "images/icon_nav_back.png",
                  width: 24.0,
                  height: 24.0,
                ),
              ),
            ),
          ),
          title: Text(
            'Genernal Setting',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          brightness: Brightness.light,
        ),
        backgroundColor: Color(0xFFF5F7F9),
        body: Column(
          children: <Widget>[
            _createEmptyItem(true, true),
            _createItem(_itemData[0][0], _itemData[0][1], () => _onItemTap(0)),
            _createLineItem(16, 16),
            _createItem(_itemData[1][0], _itemData[1][1], () => _onItemTap(1)),
            _createEmptyItem(true, true),
            _createItem(_itemData[2][0], _itemData[2][1], () => _onItemTap(2)),
            _createLineItem(16, 16),
            _createItem(_itemData[3][0], _itemData[3][1], () => _onItemTap(3)),
            _createLineItem(16, 16),
            _createItem(_itemData[4][0], _itemData[4][1], () => _onItemTap(4)),
            _createLineItem(16, 16),
            _createItem(_itemData[5][0], _itemData[5][1], () => _onItemTap(5)),
            _createLineItem(0, 0),
          ],
        ),
      ),
    );
  }

  Widget _createEmptyItem(bool topLine, bool bottomLine) {
    var list = List<Widget>();
    if (topLine) {
      list.add(Container(
        height: 0.5,
        color: Color.fromARGB(0XFF, 0xE0, 0XE0, 0XE0),
      ));
    }
    list.add(Container(
      height: 15,
      color: Color.fromARGB(0XFF, 0xF5, 0XF7, 0XF9),
    ));
    if (bottomLine) {
      list.add(Container(
        height: 0.5,
        color: Color.fromARGB(0XFF, 0xE0, 0XE0, 0XE0),
      ));
    }

    return Column(
      children: list,
    );
  }

  Widget _createLineItem(double marginStart, double marginEnd) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(marginStart, 0, marginEnd, 0),
      child: Container(
        height: 0.5,
        color: Color.fromARGB(0XFF, 0xE0, 0XE0, 0XE0),
      ),
    );
  }

  Widget _createItem(String title, String value, GestureTapCallback onTap) {
    return Container(
      height: 65,
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
                    ),
                  ),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(0xFF, 0xA1, 0xA7, 0xB2),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Image.asset(
                  "images/icon_list_next.png",
                  width: 15,
                  height: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
