import 'dart:io';

import 'package:device_info/device_info.dart';

import 'Repository.dart';
import 'models/Cart.dart';
import 'models/Item.dart';
import 'models/User.dart';

class Storage {
  Cart _cart;
  User _user;
  String _deviceId;

  set user(User user) {
    _user = user;
    if (_user != null) {
      restoreCart();
    } else {
      _cart = Cart();
    }
  }

  final Repository _repository;
  Repository get repository => _repository;

  static Future<Storage> create({Repository repository}) async {
    final ret = Storage(repository);
    ret.user = await ret.getUser();

    return ret;
  }

  User get user => _user;

  Storage(this._repository, [User user]) {
    _cart = Cart();
    _user = user;
  }

  void restoreCart() async {
    _cart = await getAllItemsInCart();
  }

  Future<Cart> getAllItemsInCart() async {
    final cartMap = await _repository.getObject(_user?.id ?? '', 'cars');
    if (cartMap == null || cartMap.isEmpty) {
      return Cart();
    }
    cartMap.map((key, value) => MapEntry(int.parse(key), 1));
    return Cart().fromMap(Map<String, dynamic>.from(cartMap));
  }

  Future<String> deviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var deviceId = '';
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = await androidInfo.androidId;
    } else {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = await iosInfo.identifierForVendor;
    }

    return deviceId;
  }

  void saveUser(User user) async {
    _deviceId = await deviceId();

    final photoLocation =
        await _repository.saveImage(_deviceId, 'avatar.jpg', user.photo);
    user.photoUrl = photoLocation;
    await _repository.saveString(_deviceId, 'user.title', user.title);
    await _repository.saveString(_deviceId, 'user.dob', user.dob);
    await _repository.saveString(_deviceId, 'user.res', user.res);
    await _repository.saveString(_deviceId, 'user.phone', user.phone);
    await _repository.saveString(_deviceId, 'user.name', user.name);
    await _repository.saveString(_deviceId, 'user.id', user.id);
    await _repository.saveString(_deviceId, 'user.photoUrl', user.photoUrl);
    await _repository.saveString(_deviceId, 'user.email', user.email);

    _user = user;
    _cart = await getAllItemsInCart();
  }

  Cart getCart(User user) {
    return _cart;
  }

  Future<User> getUser() async {

    _deviceId = await deviceId();
    final title = await _repository.getString(_deviceId, 'user.title');
    final dob = await _repository.getString(_deviceId, 'user.dob');
    final res = await _repository.getString(_deviceId, 'user.res');
    final phone = await _repository.getString(_deviceId, 'user.phone');
    final email = await _repository.getString(_deviceId, 'user.email');
    final name = await _repository.getString(_deviceId, 'user.name');
    final id = await _repository.getString(_deviceId, 'user.id');
    final url = await _repository.getString(_deviceId, 'user.photoUrl');
    final photo = await _repository.getImage(_deviceId, 'avatar.jpg');
    final isLoggedIn = await _repository.getString(_deviceId, 'user.isLoggedIn');

    if (name == null) {
      return null;
    }

    final user = User(title: title, dob: dob, res: res, phone: phone, email: email,name: name, id: id, photoUrl: url, photo: photo, isLoggedIn: isLoggedIn);

    return user;
  }

  void logout() async {
    _deviceId = await deviceId();
    await _repository.saveString(_deviceId, 'user.isLoggedIn', 'false');
  }

  void login(String li) async {
    _deviceId = await deviceId();
    await _repository.saveString(_deviceId, 'user.isLoggedIn', li.toString());
  }

  void _saveCart() async {
    await _repository.saveObject(_user.id, 'cars', _cart.toMap());
  }

  void addToCart(Item item, [int quantity = 1]) async {
    _cart.add(item);
    _saveCart();
  }

  void rO(User user){
    _saveCart();
  }
}