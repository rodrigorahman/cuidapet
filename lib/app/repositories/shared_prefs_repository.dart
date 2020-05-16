import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  
  static const _DEVICE_TOKEN = '/DEVICE_TOKEN/';
  static const _ACCESS_TOKEN = '/ACCESS_TOKEN/';
  final SharedPreferences prefs;

  SharedPrefsRepository._(this.prefs);

  static Future<SharedPrefsRepository> get instance async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsRepository._(prefs);
  }

  String get deviceToken {
    return prefs.get(_DEVICE_TOKEN);
  }
  String get accessToken => prefs.get(_ACCESS_TOKEN);

  void registerDeviceToken(String token) async {
    prefs.setString(_DEVICE_TOKEN, token);
  }
  void registerAccessToken(String token) async => prefs.setString(_ACCESS_TOKEN, token);
  
  Future<void> clear() async {
    await prefs.clear();
  }

  void logout() {
    prefs.clear();
  }
}