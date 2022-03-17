import 'package:flutter/material.dart';

class Signup_Gender_Box extends StatelessWidget {
  IconData icon;
  Color color;

  Signup_Gender_Box(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      // width: MediaQuery.of(context).size.height * 0.2,
      child: Icon(
        icon,
        size: 70,
      ),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: color),
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
