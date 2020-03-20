import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spear_motors/models/CarStore.dart';
import 'package:spear_motors/models/Item.dart';
import 'package:spear_motors/widgets/CarItem.dart';
import 'package:spear_motors/widgets/pillButton.dart';

class CarListItem extends StatefulWidget {
  final Item item;
  final int count;

  const CarListItem({Key key, this.item, this.count})
      : super(key: key);
  @override
  _CarListItemState createState() => _CarListItemState();
}

class _CarListItemState extends State<CarListItem> {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<CarStore>(context);
    final repo = app.storage;
    final user = repo.user;
    final cart = repo.getCart(user);

    return Row(
      children: <Widget>[
        Expanded(
          child: CarItem(item: widget.item),
        ),
        MaterialButton(
          minWidth: 0,
          padding: EdgeInsets.zero,
          child: PillShapedButton(
            Colors.red,
            title: 'Remove Car',
          ),
          onPressed: () {
            cart.remove(widget.item);
            app.refresh();
            repo.rO(user);
          },
        ),
      ],
    );
  }
}
