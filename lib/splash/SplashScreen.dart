import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spear_motors/models/CarStore.dart';
import 'package:spear_motors/models/User.dart';
import 'package:spear_motors/widgets/SpearMotorsLogo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool _isLoggedIn = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final app = Provider.of<CarStore>(context);
    final storage = app.storage;
    final user = await storage?.getUser();

    _isLoggedIn = user != null;
    setState(() {});
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() {
    provider.user != null
        ? Navigator.of(context).pushReplacementNamed(
            provider.user.isLoggedIn == 'false' ? '/login' : '/dashboard')
        : Navigator.of(context).pushReplacementNamed('/login');
  }

  var provider = CarStore(null, null);

  Future<User> checkData(User user) async {
    return User(
        name: user.name,
        id: user.id,
        photoUrl: user.photoUrl,
        photo: user.photo,
        email: user.email,
        title: user.title,
        dob: user.dob,
        res: user.res,
        phone: user.phone);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final app = Provider.of<CarStore>(context);
    setState(() {
      provider = app;
      if(provider.user != null)
      _isLoggedIn = true;
    });
    return Scaffold(
      body: new Container(
        width: 360.0,
        height: double.infinity,
        color: Colors.black,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpearMotorsLogo(),
            Container(
              margin: EdgeInsets.only(top: 30.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Welcome to Spear Motors Care',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: "Roboto",
                      color: Colors.white70,
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0.0),
              child: new Text(
                'For your Mercedes Benz Care',
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.italic,
                  color: Colors.white70,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget splashscreen() {
    return Scaffold(
      body: new Container(
        width: 360.0,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/favicon.png'),
            fit: BoxFit.scaleDown,
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 170.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Welcome to Spear Motors',
                    style: TextStyle(
                      fontFamily: "Roboto",
                      color: Colors.white70,
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0.0),
              child: new Text(
                'For your Mercedes Benz Care',
                style: TextStyle(
                  fontFamily: "Roboto",
                  color: Colors.white70,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
