import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spear_motors/models/CarStore.dart';

class ForgotPassword extends StatefulWidget {
  final CarStore provider;
  ForgotPassword(this.provider);

  @override
  State<StatefulWidget> createState() => FPasswordState();
}

class FPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(
          child: Text(
            "Forgot Password",
            style: TextStyle(
              color: Colors.white38,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context, 'not possible at the moment!');
              },
              child: Text('Request Password!'),
            ),
          ),
        ],
      )),
    );
  }
}
