import 'package:flutter/material.dart';

class SpearMotorsLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(7.0)),
      child: Container(
        color: Colors.black,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Image.asset(
        'assets/favicon.png',
        fit: BoxFit.fill,
      );
  }
}