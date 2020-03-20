import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  final id;
  Help(this.id);

  @override
  HelpState createState() => HelpState();
}

class HelpState extends State<Help> {
  TextEditingController question;
  FocusNode quest;
  @override
  void initState() {
    quest = FocusNode();
    super.initState();
  }
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
                  width: 90.0,
                  height: quest.hasFocus ? 30.0 : 80.0,
                  child: Image.asset('assets/favicon.png'),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Help Center',
                style: TextStyle(color: Colors.grey, fontSize: 20.0),
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'By Spear Motors',
                style:
                    TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              )
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
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: new TextFormField(
              cursorColor: Colors.grey,
              maxLines: 5,
              decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: new BorderRadius.circular(6.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: new BorderRadius.circular(6.0),
                  ),
                  border: new OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(6.0))),
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.grey,
                  hoverColor: Colors.grey,
                  hintText: 'Detail your condition as best as you can ...',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  labelText: 'Question',
                  labelStyle:
                      TextStyle(color: Colors.blueGrey, fontSize: 20.0)),
              controller: question,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context, 'Help request submitted!');
              },
              child: Text('Request for Help!'),
            ),
          ),
        ],
      )),
    );
  }
}
