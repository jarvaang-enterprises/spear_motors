import 'dart:typed_data';

import 'Item.dart';

class Cart implements MapConvertible {
  Map<String, int> _itemCounts = Map();
  Map<String, dynamic> _cars = Map();
  Map<String, int> get itemCounts => _itemCounts;
  Map<String, dynamic> get cars => _cars;

  Cart() {
    _itemCounts = Map();
    _cars = Map();
  }

  Item itemAtIndex(int index) {
    Item ret;
    final id = _itemCounts.values.toList()[index];
    _cars.forEach((k, v){
      if(k == id.toString()){
        List<int> photo = v['carPhoto'].map((s) => s as int).toList().cast<int>();
        ret = Item(id, v['year'], v['chasis'], v['regNo'], Uint8List.fromList(photo));
      }
    });
    return ret;
  }

  int countAtIndex(int index) {
    return _itemCounts.values.toList()[index];
  }

  void add(Item item, [int quantity = 1]) {
    _itemCounts[item.id.toString()] = item.id;
    _cars[item.id.toString()] = Map();
    _cars[item.id.toString()]['year'] = item.year.toString();
    _cars[item.id.toString()]['chasis'] = item.chasis.toString();
    _cars[item.id.toString()]['regNo'] = item.regNo.toString();
    _cars[item.id.toString()]['carPhoto'] = item.carPhoto;
  }

  void remove(Item item) {
    _itemCounts.remove(item.id.toString());
    _cars.remove(item.id.toString());
  }

  @override
  Map<dynamic, dynamic> toMap() {
    return _cars;
  }

  Map<dynamic, dynamic> getCars() {
    return _cars;
  }

  @override
  Cart fromMap(Map<dynamic, dynamic> map) {
    final cart = Cart();
    cart._cars = map;
    map.keys.forEach((k) => cart._itemCounts[k.toString()] = int.parse(k));
    return cart;
  }
}
