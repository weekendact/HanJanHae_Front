import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static FlutterSecureStorage userStorage = const FlutterSecureStorage();

  static Future<void> initialize() async {
    await userStorage.deleteAll();
  }

  Future<void> saveToken(String? token) async { // JWT 토큰 저장
    await userStorage.write(key: 'JWTToken', value: token);
  }

  Future<void> saveData(String dataKey, dynamic data) async { // data 저장
    await userStorage.write(key: dataKey, value: data);
  }

  Future<String?> selectToken() async { // JWT 토큰 값 찾기
    return await userStorage.read(key: 'JWTToken');
  }

  Future<String?> selectData(String selectKey) async { // 키 값으로 데이터 찾기
    return await userStorage.read(key: selectKey);
  }

  Future<void> removeToken() async { // JWT 토큰 값 삭제 
    await userStorage.delete(key: 'JWTToken');
  }

  Future<void> removeAll() async { // 전체 삭제
    await userStorage.deleteAll();
  }
}