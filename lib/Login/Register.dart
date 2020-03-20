import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spear_motors/models/CarStore.dart';
import 'package:spear_motors/models/User.dart';
import 'package:spear_motors/widgets/helper.dart';

class Register extends StatefulWidget {
  final provider;
  Register(this.provider);

  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final title = TextEditingController();
  final fName = TextEditingController();
  final dob = TextEditingController();
  final ra = TextEditingController();
  final phoneContact = TextEditingController();
  final email = TextEditingController();
  final fPass = TextEditingController();
  FocusNode ftitle;
  FocusNode fname;
  FocusNode fdob;
  FocusNode fra;
  FocusNode fphoneContact;
  FocusNode femail;
  FocusNode fpass;
  Uint8List _photoBytes;
  @override
  void initState() {
    super.initState();
    ftitle = FocusNode();
    fname = FocusNode();
    fdob = FocusNode();
    fra = FocusNode();
    fphoneContact = FocusNode();
    femail = FocusNode();
    fpass = FocusNode();
  }

  @override
  void dispose() {
    ftitle.dispose();
    fname.dispose();
    fdob.dispose();
    fra.dispose();
    fphoneContact.dispose();
    femail.dispose();
    fpass.dispose();
    super.dispose();
  }

  void _requestFocus(_fN) {
    setState(() {
      FocusScope.of(context).requestFocus(_fN);
    });
  }

  Widget _buildPhotoRow(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _photoBytes != null
              ? SizedBox.fromSize(
                  size: Size(130, 130),
                  child: Image.memory(
                    _photoBytes,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
          Container(
            width: 8,
          ),
          Text(
            _photoBytes == null ? 'Select Photo' : 'Change Photo',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      onPressed: () async {
        final bytes = await _selectPhoto(context);
        setState(() {
          _photoBytes = bytes;
        });
      },
    );
  }

  Future<Uint8List> _selectPhoto(BuildContext context) async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();
      return bytes;
    }

    return null;
  }

  void _createUser(BuildContext context) async {
    if (_photoBytes == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Please select a photo'),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return;
    }
    final user = User(
        name: fName.text,
        title: title.text,
        dob: dob.text,
        res: ra.text,
        phone: phoneContact.text,
        id: base64Encode(utf8.encode(fPass.text)),
        photo: _photoBytes,
        email: email.text);
    final app = Provider.of<CarStore>(context);
    final repo = app.storage;
    await repo.saveUser(user);

    Navigator.of(context).pop('successful ${user.name}');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(
          child: Text(
            "Spear Motors Care Register",
            style: TextStyle(
              color: Colors.white38,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
          child: new SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildPhotoRow(context),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new EnsureVisibleWhenFocused(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0.0),
                      child: new TextFormField(
                        cursorColor: Colors.grey,
                        decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0))),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.grey,
                            hoverColor: Colors.grey,
                            hintText: 'Title',
                            hintStyle: TextStyle(color: Colors.grey)),
                        controller: title,
                        focusNode: ftitle,
                        onTap: () => _requestFocus(ftitle),
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    focusNode: null),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  width: 15.0,
                  height: 15.0,
                )
              ],
            ),
            new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new EnsureVisibleWhenFocused(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 0.0),
                        child: new TextFormField(
                          cursorColor: Colors.grey,
                          decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: new BorderRadius.circular(6.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: new BorderRadius.circular(6.0),
                              ),
                              border: new OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(6.0))),
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.grey,
                              hoverColor: Colors.grey,
                              hintText: 'Full Name',
                              hintStyle: TextStyle(color: Colors.grey)),
                          controller: fName,
                          focusNode: fname,
                          onTap: () => _requestFocus(fname),
                          keyboardType: TextInputType.text,
                        )),
                    focusNode: fname)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  width: 15.0,
                  height: 15.0,
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new EnsureVisibleWhenFocused(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 0.0),
                        child: new TextFormField(
                          cursorColor: Colors.grey,
                          decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: new BorderRadius.circular(6.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: new BorderRadius.circular(6.0),
                              ),
                              border: new OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(6.0))),
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.grey,
                              hoverColor: Colors.grey,
                              hintText: 'Date of Birth (dd/mmm)',
                              hintStyle: TextStyle(color: Colors.grey)),
                          controller: dob,
                          focusNode: fdob,
                          validator: _validateEmail,
                          onTap: () => _requestFocus(fdob),
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                          keyboardType: TextInputType.datetime,
                        )),
                    focusNode: fdob)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  width: 15.0,
                  height: 15.0,
                )
              ],
            ),
            new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new EnsureVisibleWhenFocused(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0.0),
                      child: new TextFormField(
                        cursorColor: Colors.grey,
                        decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0))),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.grey,
                            hoverColor: Colors.grey,
                            hintText: 'Residence/Address',
                            hintStyle: TextStyle(color: Colors.grey)),
                        controller: ra,
                        focusNode: fra,
                        onTap: () => _requestFocus(fra),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    focusNode: fra)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  width: 15.0,
                  height: 15.0,
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new EnsureVisibleWhenFocused(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0.0),
                      child: new TextFormField(
                        cursorColor: Colors.grey,
                        decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0))),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.grey,
                            hoverColor: Colors.grey,
                            hintText: 'Phone Contact',
                            hintStyle: TextStyle(color: Colors.grey)),
                        controller: phoneContact,
                        focusNode: fphoneContact,
                        onTap: () => _requestFocus(fphoneContact),
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    focusNode: fphoneContact)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  width: 15.0,
                  height: 15.0,
                )
              ],
            ),
            new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new EnsureVisibleWhenFocused(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0.0),
                      child: new TextFormField(
                        cursorColor: Colors.grey,
                        decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0))),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.grey,
                            hoverColor: Colors.grey,
                            hintText: 'Email Address',
                            hintStyle: TextStyle(color: Colors.grey)),
                        controller: email,
                        focusNode: femail,
                        onTap: () => _requestFocus(femail),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    focusNode: null)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  width: 15.0,
                  height: 15.0,
                )
              ],
            ),
            new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new EnsureVisibleWhenFocused(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0.0),
                      child: new TextFormField(
                        cursorColor: Colors.grey,
                        decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0))),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.grey,
                            hoverColor: Colors.grey,
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey)),
                        controller: fPass,
                        focusNode: fpass,
                        obscureText: true,
                        onTap: () => _requestFocus(fpass),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    focusNode: null)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  width: 15.0,
                  height: 15.0,
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (title.text == '') {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Empty fields'),
                                  content: Text("Title Field Empty"),
                                );
                              });
                        } else if (fName.text == '') {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Empty fields'),
                                  content: Text("Full Name field is empty!"),
                                );
                              });
                        } else if (dob.text == '') {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Empty fields'),
                                  content:
                                      Text("Date of Birth field is empty!"),
                                );
                              });
                        } else if (ra.text == '') {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Empty fields'),
                                  content:
                                      Text("Residence/Address field is empty!"),
                                );
                              });
                        } else if (phoneContact.text == '') {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Empty fields'),
                                  content:
                                      Text("Phone Contact field is empty!"),
                                );
                              });
                        } else if (email.text == '') {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Empty fields'),
                                  content:
                                      Text("Email Address field is empty!"),
                                );
                              });
                        } else if (fPass.text == '') {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Empty fields'),
                                  content: Text("Password field is empty!"),
                                );
                              });
                        } else {
                          _createUser(context);
                        }
                      },
                      child: new Container(
                        alignment: Alignment.center,
                        height: 45.0,
                        decoration: new BoxDecoration(
                            color: Color(0x9797A9A2),
                            borderRadius: new BorderRadius.circular(9.0)),
                        child: new Text(
                          "Register",
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  String _validateEmail(String value) {
    if (value.trim().split('/').length != 0) {
      return value;
    } else {
      return 'Failed';
    }
  }
}
