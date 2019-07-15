import 'package:shared_preferences/shared_preferences.dart';

class AppSetting {
  AppSetting._();

  static AppSetting _instance;

  static AppSetting getInstance() {
    if (_instance == null) {
      _instance = AppSetting._();
    }
    return _instance;
  }

  static const _KEY_LANGUAGE = "KEY_LANGUAGE";
  static const _KEY_MEASURE_UNITS = "KEY_MEASURE_UNITS";
  static const _KEY_DEVICE_PWD = "device_pwd";

  Future<String> getPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_KEY_DEVICE_PWD);
  }

  void setPassword(String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(_KEY_DEVICE_PWD, password);
  }

  static const _mLocationFrequency = [10, 30, 60, 600];

  int getLocationFrequencyIndex(int frequency) {
    return _mLocationFrequency.indexOf(frequency);
  }

  int getLocationFrequencyByIndex(int index) {
    if (index != null && index >= 0 && index < _mLocationFrequency.length) {
      return _mLocationFrequency[index];
    } else {
      return getDefLocationFrequency();
    }
  }

  int getDefLocationFrequency() => _mLocationFrequency[1];

  // 获取支持的位置更新频率列表
  List<int> getSupportedLocationFrequency() => _mLocationFrequency;


  static const _LanguageNames = ["English", "Deutsch", "Français", "Español"];
  static const _LanguageCodes = ["en", "de_de", "fr_fr", "es_es"];

  List<String> getSupportedLanguage() => _LanguageNames;

  List<String> getSupportedLanguageCode() => _LanguageCodes;

  Future<int> getLanguageId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_KEY_LANGUAGE);
  }

  void setLanguageId(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(_KEY_LANGUAGE, id);
  }

  String getLanguage(int id) {
    if (id != null && id >= 0 && id < _LanguageNames.length) {
      return _LanguageNames[id];
    } else {
      return _LanguageNames[0];
    }
  }


  List<String> getSupportedMeasureUnits() {
    return <String>["meter", "yard"];
  }

  Future<int> getMeasureUnitId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_KEY_MEASURE_UNITS);
  }

  void setMeasureUnitId(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(_KEY_MEASURE_UNITS, id);
  }

  String getSystemUnit(int id) {
    if (id != null && id == 1) {
      return "m";
    } else {
      return "yd";
    }
  }

  String getSystemUnitName(int id) {
    var list = getSupportedMeasureUnits();
    if (id != null && id >= 0 && id < list.length) {
      return list[id];
    } else {
      return list[0];
    }
  }
}
