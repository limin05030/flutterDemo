class DeviceManager {

  static DeviceManager _instance;

  static DeviceManager getInstance() {
    if (_instance == null) {
      _instance = DeviceManager._();
    }
    return _instance;
  }

  DeviceManager._();

}