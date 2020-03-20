import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spear_motors/models/CarStore.dart';
import 'package:spear_motors/models/Item.dart';
import 'package:spear_motors/widgets/SpearMotorsLogo.dart';
import 'package:spear_motors/widgets/helper.dart';
import 'package:spear_motors/widgets/pillButton.dart';

class AddCar extends StatefulWidget {
  AddCar();

  @override
  AddCarState createState() => AddCarState();
}

class AddCarState extends State<AddCar> {
  final id = TextEditingController();
  final year = TextEditingController();
  final chasis = TextEditingController();
  final regNo = TextEditingController();
  final fyear = new FocusNode();
  final fchasis = new FocusNode();
  final fregNo = new FocusNode();
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  Uint8List _photoBytes;

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
            _photoBytes == null ? 'Select Photo Of Car' : 'Change Photo',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      onPressed: () async {
        _photoBytes = null;
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

  Widget _buildAddButton() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: PillShapedButton(
          null,
          title: 'Add Car',
          onPressed: () => addToCars(context),
        ),
      );
    });
  }

  void addToCars(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_photoBytes == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Please select Car photo'),
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
    final app = Provider.of<CarStore>(context);
    final repo = app.storage;
    Item item = Item(getID(), year.text, chasis.text, regNo.text, _photoBytes);

    repo.addToCart(item);
    Navigator.of(context).pop('Mercedes Benz ${item.regNo} added!');
  }

  int getID() {
    int r;
    final app = Provider.of<CarStore>(context);
    final repo = app.storage;
    final user = app.user;
    repo.getCart(user).itemCounts.values.forEach((int key) {
      r = key;
    });
    r == null ? r = 0 : r = r;
    return r + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          new Container(
            height: 12.0,
            // width: 45.0,
            child: SpearMotorsLogo(),
          )
        ],
        title: Center(
          child: Text(
            "Add Mercedes",
            style: TextStyle(
              color: Colors.white70,
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
            _buildPhotoRow(context),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Car No.${getID()}',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  width: 15.0,
                  height: 10.0,
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
                            hintText: 'Year',
                            hintStyle: TextStyle(color: Colors.grey)),
                        controller: year,
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    focusNode: fyear)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  width: 15.0,
                  height: 10.0,
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
                            hintText: 'Chasis',
                            suffixIcon: GestureDetector(
                              onTap: () =>
                                  _key.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    "Check for Chassis number from drivers door"),
                                duration: Duration(seconds: 5),
                              )),
                              child: new Icon(Icons.help_outline),
                            ),
                            suffixStyle: TextStyle(fontSize: 15.0),
                            hintStyle: TextStyle(color: Colors.grey)),
                        controller: chasis,
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    focusNode: fchasis)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                  width: 15.0,
                  height: 10.0,
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
                            hintText: 'Number Plate',
                            hintStyle: TextStyle(color: Colors.grey)),
                        controller: regNo,
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    focusNode: fregNo)
              ],
            ),
            _buildAddButton(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  _key.currentState.showSnackBar(SnackBar(
                    duration: Duration(seconds: 5),
                    content: Text("Another vehicle kind can be added"),
                  ));
                },
                child: Text('Add Another Vehicle'),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
