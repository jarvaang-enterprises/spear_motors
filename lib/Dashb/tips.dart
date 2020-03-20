import 'package:flutter/material.dart';
import 'package:spear_motors/widgets/SpearMotorsLogo.dart';

class Tips extends StatefulWidget {
  @override
  TipsState createState() => TipsState();
}

class TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SpearMotorsLogo(),
          Title(color: Colors.white, child: Text('Tips on Car Maintenance')),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Tips on Car Maintenance', style: TextStyle(color: Colors.grey, fontSize: 20.0),)
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('From Spear Motors', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),)
            ],
          ),
        ],
      )),
    );
  }
}
