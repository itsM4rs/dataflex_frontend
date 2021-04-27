import 'package:meta/meta.dart';

import '../../utils/token_secure_storage.dart';
import '../data_provider/user_provider.dart';

class UserRepository {
  final _provider = UserProvider();
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    var token =
        await _provider.getToken(username: username, password: password);
    if (token != null) {
      await TokenSecureStorage.setToken(token);
      return token;
    } else {
      return null;
    }
  }

  Future<void> deleteToken() async {
    await TokenSecureStorage.deleteToken();
  }

  Future<void> persistToken(String token) async {
    await TokenSecureStorage.setToken(token);
  }

  Future<bool> hasToken() async {
    var hasit = await TokenSecureStorage.checkToken();
    return hasit;
  }

  Future<String> getToken() async {
    var token = await TokenSecureStorage.getToken();
    return token;
  }
}
