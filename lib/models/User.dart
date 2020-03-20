import 'dart:typed_data';

class User {
  String title;
  String name;
  String dob;
  String id;
  String res;
  String phone;
  String photoUrl;
  String email;
  String isLoggedIn;
  Uint8List photo;

  User({this.name, this.id, this.photoUrl="http://placecorgi.com/150/150", this.photo, this.email = "test@example.com", this.title, this.dob, this.res, this.phone, this.isLoggedIn='false'});
}