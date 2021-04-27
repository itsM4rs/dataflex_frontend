import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/item_model.dart';
import '../repositories/user_repo.dart';
import 'components.dart';

class ItemProvider {
  final userRepository = UserRepository();

  Future<List<Item>> fetchItemsList(int id) async {
    final _url = Uri.parse(baseUrl + 'items/GetItemsInCategory/$id');
    print(_url.toString());
    List<Item> items = [];
    try {
      final token = await userRepository.getToken();
      http.Response response = await http.get(
        _url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data.map((item) => items.add(Item.fromJson(item))).toList();
        return items;
      } else {
        return null;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
