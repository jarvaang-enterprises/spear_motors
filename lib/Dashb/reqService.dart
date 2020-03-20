import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spear_motors/widgets/SpearMotorsLogo.dart';

class ReqService extends StatefulWidget {
  @override
  ReqServiceState createState() => ReqServiceState();
}

class ReqServiceState extends State<ReqService> {
  bool service = false;
  final GlobalKey<ScaffoldState> car = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    service = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: car,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(
          child: Text(
            "Service Request",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SpearMotorsLogo(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Container(
              color: Colors.white12,
              constraints:
                  BoxConstraints(maxHeight: double.infinity, maxWidth: 320.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                service = true;
                              });
                            },
                            child: Text('Service Selected'),
                          ),
                        ),
                        service
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    left: 8.0,
                                    right: 8.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    car.currentState
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(SnackBar(
                                          content: Text(
                                        "Car Selected",
                                        style: TextStyle(),
                                      )));
                                  },
                                  child: Text('Select Car'),
                                ),
                              )
                            : Padding(padding: EdgeInsets.all(5.0)),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pop(
                                  context, "Service requested successfully");
                            },
                            child: Text('Service is in development!'),
                          ),
                        ),
                      ]),
                  new Column(),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
