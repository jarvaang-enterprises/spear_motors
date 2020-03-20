import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

import '../Repository.dart';

class LocalKeyValuePersistence implements Repository {
  @override
  Future<String> saveImage(String userId, String key, Uint8List image) async {
      final base64Image = Base64Encoder().convert(image);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_generateKey(userId, key), base64Image);
      return key;
  }

  @override
  void saveObject(
      String userId, String key, Map<String, dynamic> object) async {
        final prefs = await SharedPreferences.getInstance();
        final string = JsonEncoder().convert(object);
        await prefs.setString(_generateKey(userId, key), string);
      }

  String _generateKey(String userId, String key) {
    return base64Encode(utf8.encode('$userId/$key'));
  }
  @override
  void saveString(String userId, String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_generateKey(userId, key), value);
  }

  @override
  Future<Uint8List> getImage(String userId, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final base64Image = prefs.getString(_generateKey(userId, key));
    if(base64Image != null) return Base64Decoder().convert(base64Image);
    return null;
  }

  @override
  Future<Map<String, dynamic>> getObject(String userId, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final objectString = prefs.getString(_generateKey(userId, key));
    if(objectString != null) return JsonDecoder().convert(objectString) as Map<String, dynamic>;
    return null;
  }

  @override
  Future<String> getString(String userId, String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_generateKey(userId, key));
  }

  @override
  Future<void> removeImage(String userId, String key) async {}

  @override
  Future<void> removeObject(String userId, String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_generateKey(userId, key));
  }

  @override
  Future<void> removeString(String userId, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_generateKey(userId, key));
  }
}