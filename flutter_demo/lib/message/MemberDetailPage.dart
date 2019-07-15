import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Header.dart';
import 'GMember.dart';

class MemberDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MemberDetailPageState();
}

typedef OnItemClick = void Function(int index);

class _MemberDetailPageState extends State<MemberDetailPage> {
  final memberList = List<GMember>();

  final _deviceConnected = true;

  void _onBackPressed() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      for (int i = 1; i < 10; i++) {
        memberList.add(GMember(
          onLine: Random().nextBool(),
          isMyDevice: i == 1,
          distance: Random().nextDouble(),
          name: Random().nextBool() ? "item$i" : "",
          deviceId: "0000$i",
          time: DateTime.now().millisecondsSinceEpoch,
          fenced: i != 1 && Random().nextBool(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (_deviceConnected) {
      actions = <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/icon_nav_invitable.png",
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      ];
    }

    return WillPopScope(
      onWillPop: () {
        _onBackPressed();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: Header(
          leadingAction: _onBackPressed,
          title: "Members",
          actions: actions,
        ),
        backgroundColor: Color(0xFFF5F7F9),
        body: Column(
          children: <Widget>[
            Container(
              height: 0.5,
              color: Color(0xFFE0E0E0),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              height: 0.5,
              color: Color(0xFFE0E0E0),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: memberList.length,
                itemBuilder: (context, index) {
                  return _createItem(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createItem(int index) {
    GMember member = memberList[index];

    String icon;
    String dot;
    if (member.onLine) {
      icon = "images/notice_member_normal.png";
      dot = "images/icon_member_online.png";
    } else {
      icon = "images/notice_member_offline.png";
      dot = "images/icon_member_offline.png";
    }

    Widget photo = Container(
      width: 68,
      height: 77,
      padding: EdgeInsets.fromLTRB(19, 20, 12, 20),
      child: Stack(
        children: <Widget>[
          Image.asset(icon, width: 37, height: 37,),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(dot, width: 10, height: 10,),
          ),
        ],
      ),
    );

    List<Widget> contentList = List();
    String name;
    if (member.name == null || member.name.isEmpty) {
      name = member.deviceId;
    } else {
      name = "${member.name}(Devie ID:${member.deviceId})";
    }
    contentList.add(Text(
      name,
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF333333),
      ),
    ));

    if (member.isMyDevice) {
      contentList.add(Padding(
        padding: EdgeInsets.only(top: 4),
        child: Text(
          "My Device",
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFFA1A7B2),
          ),
        ),
      ));
    } else {
      if (member.onLine) {
        contentList.add(Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            "${member.distance.toStringAsFixed(2)}m for me",
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFFA1A7B2),
            ),
          ),
        ));
      } else {
        contentList.add(Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            "offline-time: ${DateFormat.yMd().add_Hms().format(DateTime.fromMillisecondsSinceEpoch(member.time, isUtc: false))}",
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFFA1A7B2),
            ),
          ),
        ));

        contentList.add(Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            "${member.distance.toStringAsFixed(2)}m for me",
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFFA1A7B2),
            ),
          ),
        ));
      }
    }

    Widget fence;
    if (member.fenced) {
      String fencePath;
      if (member.onLine) {
        fencePath = "images/icon_fence_online.png";
      } else {
        fencePath = "images/icon_fence_offline.png";
      }
      fence = Container(
        margin: EdgeInsets.only(right: 16),
        width: 15,
        height: 15,
        child: Image.asset(
          fencePath,
          width: 15,
          height: 15,
        ),
      );
    } else {
      fence = Container(
        margin: EdgeInsets.only(right: 16),
        width: 15,
        height: 15,
      );
    }

    return Container(
      height: 77.5,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              photo,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: contentList,
                ),
              ),
              fence,
            ],
          ),

          Container(
            height: 0.5,
            color: Color(0xFFE0E0E0),
          )
        ],
      ),
    );
  }
}
