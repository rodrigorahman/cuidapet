import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityStorageRepository {
  
  static const REFRESH_TOKEN = '/REFRESH_TOKEN/';
  
  Future<void> registerRefreshToken(String token) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: REFRESH_TOKEN, value: token);
  }

  Future<String> getRefreshToken(String token) async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: REFRESH_TOKEN);
  }


}