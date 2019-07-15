


typedef void DartEventCallback(arg);

class BluetoothWrapper {
  static BluetoothWrapper _instance;

  static BluetoothWrapper getInstance() {
    if (_instance == null) {
      _instance = BluetoothWrapper._();
    }
    return _instance;
  }

  BluetoothWrapper._();


}