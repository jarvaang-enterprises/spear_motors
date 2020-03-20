import 'package:flutter/material.dart';
import 'package:spear_motors/models/Item.dart';
import 'package:spear_motors/widgets/CarImageView.dart';

class CarItem extends StatelessWidget {
  final Item item;

  const CarItem({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(children: <Widget>[
        SizedBox.fromSize(
          size: Size(60.0, 60.0),
          child: CarImageView(
            name: item.regNo,
            photo: item.carPhoto,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  item.regNo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${item.chasis}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.withAlpha(150)
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
