import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static FlutterSecureStorage userStorage = const FlutterSecureStorage();

  static Future<void> initialize() async {
    await userStorage.deleteAll();
  }

  Future<void> saveToken(String? token) async {
    await userStorage.write(key: 'accessToken', value: token);
  }

  Future<String?> readToken() async {
    return await userStorage.read(key: 'accessToken');
  }

  Future<void> removeToken() async {
    await userStorage.delete(key: 'accessToken');
  }
}
