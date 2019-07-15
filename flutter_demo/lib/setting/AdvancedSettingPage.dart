import 'package:flutter/material.dart';

import '../Header.dart';

class AdvancedSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdvancedSettingPageState();
}

typedef OnItemClick = void Function(int index);

class _AdvancedSettingPageState extends State<AdvancedSettingPage> {

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onItemClick(int index) {

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
          title: "Advanced Setting",
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
              padding: EdgeInsets.only(left: 16, top: 30, right: 16, bottom: 30),
              child: Text(
                "You can bulkily modify the device ID, the message password, or the region for all devices in Advanced Settings.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8A8F99),
                ),
              ),
            ),
            Container(
              height: 0.5,
              color: Color(0xFFE0E0E0),
            ),

            _createItem("Message Password", 0, _onItemClick),

            Container(
              height: 0.5,
              margin: EdgeInsets.only(left: 16, right: 16,),
              color: Color(0xFFE0E0E0),
            ),

            _createItem("Region", 1, _onItemClick),

            Container(
              height: 0.5,
              color: Color(0xFFE0E0E0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createItem(String title, int index, OnItemClick clickAction) {
    return Container(
      height: 65,
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            clickAction(index);
          },
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(right: 26),
                child: Image.asset("images/icon_list_next.png", width: 15, height: 15,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
