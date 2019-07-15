import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';

import '../PermissionManager.dart';

class LocationManager {

  static Future<LocationData> getLocation() async {
    var granted = await PermissionManager.requestPermission(PermissionGroup.location);
    if (granted) {
      try {
        return await Location().getLocation();
      } catch (e) {
        print("e");
      }
    }

    return null;
  }
}