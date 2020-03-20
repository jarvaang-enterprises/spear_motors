import 'dart:typed_data';

abstract class MapConvertible {
  Map<dynamic, dynamic> toMap();

  MapConvertible fromMap(Map<dynamic, dynamic> map);
}

class Item {
  final int id;
  final String year;
  final String chasis;
  final String regNo;

  Uint8List carPhoto;

  Item(this.id, this.year, this.chasis, this.regNo, this.carPhoto);
}