import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spear_motors/choice.dart';
import 'package:spear_motors/models/CarStore.dart';
import 'package:spear_motors/models/User.dart';

class Dashboard extends StatefulWidget {
  final userdata;
  final provider;
  Dashboard(this.userdata, this.provider);

  @override
  State<StatefulWidget> createState() => DashboardState(provider);
}

class DashboardState extends State<Dashboard> {
  String txt;
  bool snackbar = false;
  dynamic p;
  final GlobalKey<ScaffoldState> main = new GlobalKey<ScaffoldState>();

  DashboardState(this.p);
  @override
  void initState() {
    setState(() {
      snackbar = false;
      txt = '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CarStore>(context);
    return FutureBuilder<User>(
      future: widget.userdata,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Scaffold(appBar: AppBar(), body: Text('No connection!'));
            break;
          case ConnectionState.waiting:
            return Scaffold(
                appBar: AppBar(),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                            strokeWidth: 4.0),
                      )
                    ]));
            break;
          default:
            if (snapshot.hasError) {
              return Scaffold(
                body: Text("Error: ${snapshot.error}"),
                appBar: AppBar(),
              );
            } else {
              var username = snapshot.data.name;
              return Scaffold(
                key: main,
                backgroundColor: Colors.black,
                appBar: AppBar(backgroundColor: Colors.black, actions: <Widget>[
                  _itemDown(snapshot),
                ]),
                body: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Material(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        shadowColor: Colors.blueGrey,
                        child: SizedBox.fromSize(
                          size: Size(120, 120),
                          child: Image.memory(
                            snapshot.data.photo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: Text(
                        "$username",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: Container(
                          child: Center(
                        child: new TextFormField(
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true,
                          enabled: false,
                          initialValue: snapshot.data.email,
                          style: TextStyle(color: Colors.grey),
                        ),
                      )),
                    ),
                    Divider(
                      color: Colors.blueGrey,
                      height: 4.0,
                      indent: 30.0,
                      endIndent: 30.0,
                      thickness: 3.0,
                    ),
                    new GestureDetector(
                      onTap: () => _addCar(context, snapshot, provider),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Image.asset(
                              'assets/carIcon.png',
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 40.0),
                            child: new Text(
                              "+Add Cars",
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.blueGrey,
                      height: 3.0,
                      indent: 35.0,
                      endIndent: 35.0,
                      thickness: 1.0,
                    ),
                    new GestureDetector(
                      onTap: () => _reqService(context, snapshot),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Image.asset(
                                'assets/icons/service.png',
                                color: Colors.white70,
                                height: 50.0,
                                width: 50.0,
                              )),
                          Padding(
                            padding: EdgeInsets.only(left: 40.0),
                            child: new Text(
                              "+Request for Service",
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.blueGrey,
                      height: 3.0,
                      indent: 35.0,
                      endIndent: 35.0,
                      thickness: 1.0,
                    ),
                    new GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed('/tips'),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Image.asset(
                              'assets/icons/tips.png',
                              color: Colors.white70,
                              height: 60.0,
                              width: 60.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: new Text(
                              "+Tips on car maintenance",
                              style:
                                  TextStyle(fontSize: 17.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.blueGrey,
                      height: 3.0,
                      indent: 35.0,
                      endIndent: 35.0,
                      thickness: 1.0,
                    ),
                    new GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed('/profile'),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Image.asset(
                              'assets/icons/profile.png',
                              color: Colors.white70,
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 40.0),
                            child: new Text(
                              "+User Profile",
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.blueGrey,
                      height: 3.0,
                      indent: 35.0,
                      endIndent: 35.0,
                      thickness: 1.0,
                    ),
                    new GestureDetector(
                        onTap: () => _help(context, snapshot),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 30.0, bottom: 0.0),
                              child: Image.asset(
                                'assets/icons/help.png',
                                color: Colors.white70,
                                height: 50.0,
                                width: 50.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 40.0),
                              child: new Text(
                                "+Help",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.grey),
                              ),
                            ),
                          ],
                        )),
                    Divider(
                      color: Colors.blueGrey,
                      height: 3.0,
                      indent: 35.0,
                      endIndent: 35.0,
                      thickness: 1.0,
                    ),
                  ],
                )),
              );
            }
        }
      },
    );
  }

  _addCar(BuildContext context, dynamic snapshot, dynamic provider) async {
    final result = await Navigator.of(context).pushNamed('/addCar');
    if (result != null) {
      main.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(
          "$result!",
          style: TextStyle(),
        )));
    }
  }

  _help(BuildContext context, dynamic snapshot) async {
    final result = await Navigator.of(context).pushNamed('/help');
    if (result != null) {
      main.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(
          "$result!",
          style: TextStyle(),
        )));
    }
  }

  _reqService(BuildContext context, dynamic snapshot) async {
    final result = await Navigator.of(context).pushNamed('/reqService');
    if (result != null) {
      main.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(
          "$result!",
          style: TextStyle(),
        )));
    }
  }

  Choice _value = choices[0];
  void _select(Choice choice, {s}) {
    setState(() {
      _value = choice;
    });
    if (choice.title == 'Logout') {
      p.storage.logout();
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  PopupMenuButton _itemDown(s) => PopupMenuButton<Choice>(
        onSelected: _select,
        color: Colors.grey,
        child: Padding(
            padding:
                EdgeInsets.only(top: 8.0, bottom: 8.0, left: 5.0, right: 9.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.dehaze,
                  size: 40.0,
                  semanticLabel: "Options",
                ),
              ],
            )),
        itemBuilder: (context) {
          return choices.map((Choice f) {
            return PopupMenuItem<Choice>(
                value: f,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      f.icon,
                      color: Colors.blueGrey,
                    ),
                    Text(f.title)
                  ],
                ));
          }).toList();
        },
      );
}
