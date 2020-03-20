import 'package:flutter/material.dart';

import '../Storage.dart';
import 'Store.dart';
import 'User.dart';

class CarStore with ChangeNotifier {
  CarStore(this._store, this._storage);

  final Store _store;
  final Storage _storage;

  Store get store => _store;

  Storage get storage => _storage;

  User get user => _storage?.user;

  void refresh() {
    notifyListeners();
  }

  void logout() async {
    await _storage.logout();
  }
}