import '../location/LatLng.dart';

class GMessage {
  int type;
  var deviceID = "";

  int time = DateTime.now().millisecondsSinceEpoch;

  var locationName = "";

  LatLng location;

  var msg = "";

  int vocId = 0;

  var vocTargetID = "";

  GMessageSendStatus sendStatus = GMessageSendStatus.SEND_FAIL;

  int sendCount = 0;

  // 在数据库中的记录编号
  int id = -1;

  String getContent() {
    switch (type) {
      case GMessageType.TYPE_MSG:
        return msg;
      case GMessageType.TYPE_LOC:
      case GMessageType.TYPE_SOS:
      case GMessageType.TYPE_PIN:
      case GMessageType.TYPE_PIN_TOP:
        return _encodeLocation();
      case GMessageType.TYPE_VOC:
        return "$vocId,$vocTargetID";
      default:
        return "";
    }
  }

  bool setContent(String content) {
    switch (type) {
      case GMessageType.TYPE_MSG:
        this.msg = content;
        break;

      case GMessageType.TYPE_LOC:
      case GMessageType.TYPE_SOS:
      case GMessageType.TYPE_PIN:
      case GMessageType.TYPE_PIN_TOP:
        if (!_decodeLocation(content)) {
          return false;
        }
        break;

      case GMessageType.TYPE_VOC:
        var arr = content.split(",");
        this.vocId = int.parse(arr[0]);
        this.vocTargetID = arr[1];
        break;
    }

    return true;
  }

  String _encodeLocation() {
    return "${location.lat},${location.lon},$locationName";
  }

  bool _decodeLocation(String content) {
    try {
      var arr = content.split(",");
      this.location = LatLng(double.parse(arr[0]), double.parse(arr[1]));
      this.locationName = (arr.length == 3) ? arr[2] : "";
      return true;
    } on Exception catch (e) {
      print("$e");
      return false;
    }
  }
}

class GMessageType {
  static const int TYPE_MSG = 1;
  static const int TYPE_LOC = 2;
  static const int TYPE_SOS = 3;
  static const int TYPE_PIN = 4;
  static const int TYPE_PIN_TOP = 5;
  static const int TYPE_VOC = 6;
}

enum GMessageSendStatus { SEND_FAIL, SEND_OK, SENDING }
