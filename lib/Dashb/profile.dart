import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spear_motors/models/CarStore.dart';
import 'package:spear_motors/models/Cart.dart';
import 'package:spear_motors/widgets/CarListItem.dart';

class Profile extends StatefulWidget {
  final id;
  final CarStore provider;
  Profile(this.id, this.provider);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  Widget _buildPhotoRow(BuildContext context) {
    final app = Provider.of<CarStore>(context);
    Uint8List _photoBytes = app.storage.user.photo;
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _photoBytes != null
              ? Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Material(
                    elevation: 4.0,
                    shape: CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    shadowColor: Colors.blueGrey,
                    child: SizedBox.fromSize(
                      size: Size(130, 130),
                      child: Image.memory(
                        _photoBytes,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : Container(),
          Container(
            width: 8,
          ),
          Text(
            _photoBytes == null ? 'Select Photo' : '',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      onPressed: null,
    );
  }

  Widget _buildList(Cart cart) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cart.itemCounts.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, int index) {
        final item = cart.itemAtIndex(index);
        final count = cart.countAtIndex(index);
        return CarListItem(item: item, count: count);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<CarStore>(context);
    final repository = app.storage;
    final user = app.user;
    final cart = repository.getCart(user);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: Center(
          child: Text(
            "User Profile",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildPhotoRow(context),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: new Row(
                    children: <Widget>[
                      Text('Full Name: ', style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                      Text(
                          '${app.user.title} ${app.user.name}',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16.5)),
                    ],
                  )),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: new Row(
                  children: <Widget>[
                    Text('Email Address: ',
                        style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                    Text('${app.user.email}',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16.5)),
                  ],
                ),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: new Row(
                  children: <Widget>[
                    Text('Date of Birth: ',
                        style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                    Text('${app.user.dob.trim()}',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16.5)),
                  ],
                ),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: new Row(
                  children: <Widget>[
                    Text('Residence/Address: ',
                        style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                    Text('${app.user.res.trim()}',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16.5)),
                  ],
                ),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: new Row(
                  children: <Widget>[
                    Text('Mobile Number: ',
                        style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                    Text('${app.user.phone}',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16.5)),
                  ],
                ),
              ),
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
          cart.cars.length != 0
              ? Text(
                  'Your cars are as follows:',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                )
              : Text(
                  'You don`t have cars yet.\nPlease add a Car from the dashboard!',
                  style: TextStyle(color: Colors.grey),
                ),
          cart.cars.length != 0 ? _buildList(cart) : new Container()
        ],
      )),
    );
  }
}
