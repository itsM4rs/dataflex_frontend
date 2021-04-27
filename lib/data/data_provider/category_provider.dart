import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/category_model.dart';
import '../repositories/user_repo.dart';
import 'components.dart';

class CategoryProvider {
  final _url = Uri.parse(baseUrl + 'categories');
  final userRepository = UserRepository();

  Future<List<Category>> fetchCategoriesList() async {
    List<Category> categories = [];
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
        data
            .map((category) => categories.add(Category.fromJson(category)))
            .toList();
        return categories;
      } else {
        return null;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
