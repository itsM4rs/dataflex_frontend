import '../data_provider/category_provider.dart';
import '../models/category_model.dart';

class CategoryRepository {
  final _provider = CategoryProvider();

  Future<List<Category>> fetchCategoriesList() async {
    return await _provider.fetchCategoriesList();
  }
}

class NetworkError extends Error {}
