import 'package:flutter/material.dart';

class Input_Field extends StatelessWidget {
  String text;
  String? ctext;
  IconData? icon;
  bool? obs;
  TextInputType? type;

  Input_Field(
    this.text, {
    this.icon,
    this.type,
    this.ctext,
    this.obs
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty)
          return '$text required';
        else if (text == 'Email' && !value.contains('@'))
          return 'Enter a valid email';
        else if (text == 'Password' && value.length < 7)
          return 'Password must be at least 7 characters';
        else if (text == 'Confirm Password' && value != ctext)
          return 'Password didn\'t match';
        else
          return null;
      },
      onSaved: (value) {},
      keyboardType: type,
      obscureText: obs??false,
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
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
    );
  }
}
