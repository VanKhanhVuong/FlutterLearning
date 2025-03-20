import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
    print('Data written to secure storage');
  }

  Future<String> readSecureData(String key) async {
    String value = await storage.read(key: key) ?? '';
    return value;
  }

  deleteSecureData(String key) async {
    await storage.delete(key: key);
    print('Data deleted from secure storage');
  }
}
