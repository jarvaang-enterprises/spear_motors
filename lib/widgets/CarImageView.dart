import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class CarImageView extends StatelessWidget {
  final String name;
  final Uint8List photo;
  final Color color;
  final int letterCount;

  CarImageView({
    this.name,
    this.photo,
    this.color = Colors.white,
    this.letterCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _pickColors();

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(7.0)),
      child: Container(
        color: colors[0],
        child: _buildContent(colors[1]),
      ),
    );
  }

  List<Color> _pickColors() {
    final colors = [
      [Color(0xff6292e6), Color(0x979797ff)],
      [Color(0xffff8484), Color(0xffffffff)],
      [Color(0xfff5a623), Color(0xffffffff)],
      [Color(0xff99bdfb), Color(0xffffffff)],
    ];

    final rand = Random(name.hashCode).nextInt(colors.length);
    return colors[rand];
  }

  Widget _buildContent(Color textColor) {
    if (photo==null) {
      final initials = name
          .trim()
          .split(' ')
          .map((word) => word.substring(0, 1))
          .take(letterCount)
          .join()
          .toUpperCase();
      return Text(
        initials,
        style: TextStyle(color: textColor, fontSize: 14),
      );
    } else {
      return Image.memory(
        photo,
        fit: BoxFit.cover,
      );
    }
  }
}