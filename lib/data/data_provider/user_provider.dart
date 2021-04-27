import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../models/user_model.dart';
import 'components.dart';

class UserProvider {
  final _url = Uri.parse(baseUrl + 'users/authenticate');

  Future<String> getToken({
    @required String username,
    @required String password,
  }) async {
    var user = User(id: 0, username: username, password: password, token: "");
    var response = await http.post(_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: user.toJson());

    if (response.statusCode == 200) {
      user = User.fromJson(response.body);
      return user.token;
    } else {
      return null;
    }
  }
}
