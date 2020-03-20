import 'package:flutter/material.dart';

class Choice {
  Choice({this.title, this.icon});
  final String title;
  dynamic icon;
}

List<Choice> choices = <Choice> [
  Choice(title: 'Logout', icon: Icons.exit_to_app),
  // Choice(title: 'View Cars', icon: Image.asset('assets/carIcon.png'))
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 20.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}