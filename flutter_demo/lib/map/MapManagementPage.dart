import 'package:flutter/material.dart';

import '../Header.dart';

class MapManagementPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapManagementPageState();
}

class _MapManagementPageState extends State<MapManagementPage> {
  void _onBackPressed() {
    Navigator.pop(context);
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
          title: "Map Managment",
        ),
        backgroundColor: Color(0xFFF5F7F9),
        body: Center(
          child: Text("Map Management"),
        ),
      ),
    );
  }
}
