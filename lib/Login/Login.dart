import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spear_motors/models/CarStore.dart';
import 'package:spear_motors/models/User.dart';
import 'package:spear_motors/widgets/helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CarStore>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: Center(
          child: Text(
            "Spear Motors Auto Care",
            style: TextStyle(
              color: Colors.white38,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new Container(
                      child: new Login(),
                    ),
                  )
                ],
              ),
            ]),
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final tPass = TextEditingController();
  final tUser = TextEditingController();
  String msg = '';
  FocusNode user;
  FocusNode pass;
  Color ucolor;
  Color pcolor;

  @override
  void initState() {
    super.initState();
    msg = '';
    user = FocusNode();
    pass = FocusNode();
    user.addListener(_focusListener);
    pass.addListener(_focusListener);
  }

  @override
  void dispose() {
    user.dispose();
    pass.dispose();
    user.removeListener(_focusListener);
    pass.removeListener(_focusListener);
    super.dispose();
  }

  void _requestFocus(_fN) {
    setState(() {
      msg = '';
      FocusScope.of(context).requestFocus(_fN);
    });
  }

  Future<Null> _focusListener() async {
    if (user.hasFocus) {}
  }

  @override
  void didChangeMetrics() {}

  Future<User> cData(User user) async {
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

  Future<User> checkData(passd, usr, BuildContext context) async {
    final provider = Provider.of<CarStore>(context);
    if (usr != '' || passd != '') {
      if (provider.user != null) {
        if (provider.user.email == usr &&
            provider.user.id == base64Encode(utf8.encode(passd))) {
          provider.storage.login('true');
          return cData(provider.user);
        } else if (provider.user.email == usr &&
            provider.user.id != base64Encode(utf8.encode(passd))) {
          tPass.text = '';
          _requestFocus(pass);
          setState(() {
            msg = "The password is invalid!";
            pcolor = Colors.red;
          });
        } else if (provider.user.email != usr) {
          tPass.text = '';
          tUser.text = '';
          _requestFocus(user);
          setState(() {
            msg = 'The user is invalid!';
            ucolor = Colors.red;
          });
        }
      } else {
        setState(() {
          msg = 'Please create an account first!';
        });
      }
    }
    return null;
  }

  _authData(String passwd, String usr, BuildContext context) async {
    var result = checkData(passwd, usr, context);
    var r = await result;
    try {
      if (r != null) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } on NoSuchMethodError catch (_) {}
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: new Container(
          width: 300.0,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 90.0,
                    margin: EdgeInsets.symmetric(
                        vertical:
                            user.hasFocus ? 0.0 : pass.hasFocus ? 0.0 : 20.0,
                        horizontal: 0.0),
                    height: user.hasFocus ? 30.0 : pass.hasFocus ? 30.0 : 80.0,
                    child: Image.asset('assets/favicon.png'),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(
                            msg,
                            style: TextStyle(color: Colors.red, fontSize: 12.0),
                          ))),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(
                    width: 250.0,
                    height: 15.5,
                  )
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new EnsureVisibleWhenFocused(
                      child: new TextFormField(
                        cursorColor: Colors.grey,
                        decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ucolor == null ? Colors.grey : ucolor,
                                  width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ucolor == null ? Colors.grey : ucolor,
                                  width: msg == '' ? 2.0 : 4.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ucolor == null
                                        ? Colors.white30
                                        : ucolor,
                                    width: msg == '' ? 2.0 : 4.0),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0))),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.grey,
                            hoverColor: Colors.grey,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.grey)),
                        controller: tUser,
                        focusNode: user,
                        onTap: () => _requestFocus(user),
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                        keyboardType: TextInputType.text,
                      ),
                      focusNode: user),
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
                      child: new TextField(
                        cursorColor: Colors.grey,
                        obscureText: true,
                        decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: pcolor == null ? Colors.grey : pcolor,
                                  width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: pcolor == null ? Colors.grey : pcolor,
                                  width: 2.0),
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        pcolor == null ? Colors.grey : pcolor,
                                    width: 2.0),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0))),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.grey,
                            hoverColor: Colors.grey,
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey)),
                        controller: tPass,
                        focusNode: pass,
                        onTap: () => _requestFocus(pass),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      focusNode: pass)
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
                          setState(() {});
                          if (tUser.text == '') {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("Email Field empty!"),
                                  );
                                });
                          } else if (tPass.text == '') {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("Password field is empty!"),
                                  );
                                });
                          } else {
                            return _authData(tPass.text, tUser.text, context);
                          }
                        },
                        child: new Container(
                          alignment: Alignment.center,
                          height: 45.0,
                          decoration: new BoxDecoration(
                              color: Color(0x9797A9A2),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Login",
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
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
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () => _register(context),
                    child: new Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  new Text(' | ', style: TextStyle(color: Colors.grey)),
                  new GestureDetector(
                      onTap: () => _forgotPasswd(context),
                      child: new Text("Forgot Password!",
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.underline))),
                ],
              )
            ],
          )),
    );
  }

  _forgotPasswd(BuildContext context) async {
    final res = await Navigator.of(context).pushNamed('/forgotPasswd');
    if (res != null) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("Password reset $res")));
    }
  }

  _register(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/register');
    if (result != null) {
      setState(() {
        msg = 'Please Login now!';
      });
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(
          "Account registration $result!",
          style: TextStyle(),
        )));
    }
  }
}
