import 'package:permission_handler/permission_handler.dart';

class PermissionManager {

  static Future<bool> checkPermission(PermissionGroup permissionGroup) async {
    PermissionStatus status = await PermissionHandler().checkPermissionStatus(permissionGroup);
    return status == PermissionStatus.granted;
  }

  static Future<bool> requestPermission(PermissionGroup permission) async {
    final List<PermissionGroup> permissions = <PermissionGroup>[permission];
    final Map<PermissionGroup, PermissionStatus> result = await PermissionHandler().requestPermissions(permissions);
    return result[permission] == PermissionStatus.granted;
  }

  static Future<Map<PermissionGroup, bool>> requestPermissions(List<PermissionGroup> permissions) async {
    final Map<PermissionGroup, PermissionStatus> result = await PermissionHandler().requestPermissions(permissions);
    return result.map((key, value) => MapEntry(key, value == PermissionStatus.granted));
  }
}