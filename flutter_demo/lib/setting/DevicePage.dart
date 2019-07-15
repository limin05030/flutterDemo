import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DevicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {

  bool _doneActionEnabled = false;

  void onDoneActionClick() {

  }

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
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: InkWell(
              onTap: _onBackPressed,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Image.asset("images/icon_nav_back.png"),
              ),
            ),
          ),

          title: Text(
            "Pair with GoFindMe",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF333333),
            ),
          ),
          centerTitle: true,

          actions: <Widget>[
            _createDoneAction(onDoneActionClick),
          ],

          backgroundColor: Colors.white,
          elevation: 0,
          brightness: Brightness.light,
        ),
        body: _createBody(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _openBluetooth,
            label: Text("Bluetooth"),
        ),
      ),
    );
  }

  // https://github.com/pauldemarco/flutter_blue
  void _openBluetooth() {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    flutterBlue.isAvailable.then((isAvailable) {
      print("_openBluetooth: isAvailable: $isAvailable");
    });
    flutterBlue.isOn.then((isOn) {
      print("_openBluetooth: isOn: $isOn");
    });

  }

  Widget _createDoneAction(GestureTapCallback onActionClick) {
    TextStyle textStyle;
    if (_doneActionEnabled) {
      textStyle = TextStyle(
        fontSize: 16,
        color: Color(0xFF5886dc),
      );
    } else {
      textStyle = TextStyle(
        fontSize: 16,
        color: Color(0x7f5886dc),
      );
    }

    return Container(
      margin: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: InkWell(
        onTap: onActionClick,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Done",
            style: textStyle,
          ),
        ),
      ),
    );
  }

  Widget _createBody() {
    return Container();
  }

}
