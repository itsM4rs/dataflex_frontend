import "package:flutter_secure_storage/flutter_secure_storage.dart";

class TokenSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyToken = "token";

  static Future<void> setToken(String token) async =>
      await _storage.write(key: _keyToken, value: token);

  static Future<String> getToken() async => await _storage.read(key: _keyToken);

  static Future<void> deleteToken() async =>
      await _storage.delete(key: _keyToken);

  static Future<bool> checkToken() async {
    var token = await _storage.read(key: "token");
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }
}
