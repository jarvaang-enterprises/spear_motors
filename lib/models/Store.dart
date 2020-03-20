import 'Item.dart';

class Store {
  final List<Item> items;

  Store(this.items);

  Item itemForId(int id) {
    return items.firstWhere((item) => item.id == id);
  }
}