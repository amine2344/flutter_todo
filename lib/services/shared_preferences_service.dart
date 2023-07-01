import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesService {
  late SharedPreferences _preferences;

  Future<void> initialise() async {
    print("SharedPref initialise");
    _preferences = await SharedPreferences.getInstance();
  }

  static const String UID = 'uid';
  static const String TOKEN = 'token';


  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  Future<void> clearData() async {
    await _preferences.clear();
  }

  String? get uid => _getFromDisk(UID);

  set uid(String? value) => _saveToDisk(UID, value);

  String? get token => _getFromDisk(TOKEN);

  set token(String? value) => _saveToDisk(TOKEN, value);
}