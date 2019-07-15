import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'PermissionManager.dart';


class PermissionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                PermissionHandler().openAppSettings().then((bool hasOpened) =>
                    debugPrint('App Settings opened: ' + hasOpened.toString()));
              },
            )
          ],
        ),
        body: Center(
          child: ListView(
              children: PermissionGroup.values.where((PermissionGroup permission) {
                if (Platform.isIOS) {
                  return permission != PermissionGroup.unknown &&
                      permission != PermissionGroup.sms &&
                      permission != PermissionGroup.storage/* &&
                      permission != PermissionGroup.ignoreBatteryOptimizations*/;
                } else {
                  return permission != PermissionGroup.unknown &&
                      permission != PermissionGroup.mediaLibrary &&
                      permission != PermissionGroup.photos &&
                      permission != PermissionGroup.reminders;
                }
              }).map((PermissionGroup permission) => PermissionWidget(permission)).toList()
          ),
        ),
      ),
    );
  }
}

class PermissionWidget extends StatefulWidget {
  const PermissionWidget(this._permissionGroup);

  final PermissionGroup _permissionGroup;

  @override
  _PermissionState createState() => _PermissionState(_permissionGroup);
}

class _PermissionState extends State<PermissionWidget> {
  _PermissionState(this._permissionGroup);

  final PermissionGroup _permissionGroup;
//  PermissionStatus _permissionStatus = PermissionStatus.unknown;
  bool _permissionStatus = false;

  @override
  void initState() {
    super.initState();

    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() {
//    final Future<PermissionStatus> statusFuture =
//    PermissionHandler().checkPermissionStatus(_permissionGroup);
//
//    statusFuture.then((PermissionStatus status) {
//      setState(() {
//        _permissionStatus = status;
//      });
//    });

    PermissionManager.checkPermission(_permissionGroup).then((granted) {
      setState(() {
        _permissionStatus = granted;
      });
    });
  }

  Color getPermissionColor() {
//    switch (_permissionStatus) {
//      case PermissionStatus.denied:
//        return Colors.red;
//      case PermissionStatus.granted:
//        return Colors.green;
//      default:
//        return Colors.grey;
//    }
    if (_permissionStatus) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_permissionGroup.toString()),
      subtitle: Text(
        _permissionStatus ? "granted" : "denied",
        style: TextStyle(color: getPermissionColor()),
      ),
      trailing: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            checkServiceStatus(context, _permissionGroup);
          }),
      onTap: () {
        requestPermission(_permissionGroup);
      },
    );
  }

  void checkServiceStatus(BuildContext context, PermissionGroup permission) {
    PermissionHandler()
        .checkServiceStatus(permission)
        .then((ServiceStatus serviceStatus) {
      final SnackBar snackBar =
      SnackBar(content: Text(serviceStatus.toString()));

      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void requestPermission(PermissionGroup permission) {
//    final List<PermissionGroup> permissions = <PermissionGroup>[permission];
//    final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
//    await PermissionHandler().requestPermissions(permissions);
//
//    setState(() {
//      print(permissionRequestResult);
//      _permissionStatus = permissionRequestResult[permission];
//      print(_permissionStatus);
//    });
    PermissionManager.requestPermission(permission).then((granted) {
      setState(() {
        print("permissionRequestResult: $granted");
        _permissionStatus = granted;
      });
    });
  }
}