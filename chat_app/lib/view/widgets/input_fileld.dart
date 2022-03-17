import 'package:flutter/material.dart';

class Input_Field extends StatelessWidget {
  String text;
  IconData? icon;
  TextInputType? type;
  Input_Field(this.text, {this.icon, this.type});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      decoration: InputDecoration(
          suffixIcon: Icon(
            icon,
            color: Colors.black54,
          ),
          label: Text(text),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }
}
