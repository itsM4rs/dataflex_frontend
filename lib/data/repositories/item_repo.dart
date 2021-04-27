import '../data_provider/item_provider.dart';
import '../models/item_model.dart';

class ItemRepository {
  final _provider = ItemProvider();

  Future<List<Item>> fetchItemsList(int id) async {
    return await _provider.fetchItemsList(id);
  }
}
