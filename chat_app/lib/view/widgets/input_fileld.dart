import 'package:flutter/material.dart';

class Input_Field extends StatefulWidget {
  String text;
  String? ctext;
  IconData? icon;
  TextInputType? type;
  TextEditingController controller;

  Input_Field(
    this.text,
    this.controller, {
    this.icon,
    this.type,
    this.ctext,
  });

  @override
  State<Input_Field> createState() => _Input_FieldState();
}

bool obs = false;

class _Input_FieldState extends State<Input_Field> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value!.isEmpty)
          return '${widget.text} required';
        else if (widget.text == 'Email' && !value.contains('@gmail.com'))
          return 'invalid email "Example@gmail.com"';
        else if (widget.text == 'Password' && value.length < 7)
          return 'Password must be at least 7 characters';
        else if (widget.text == 'Confirm Password' &&
            value.compareTo(widget.ctext.toString()) != 0) {
          print(value);
          print(widget.ctext);
          return 'Password didn\'t match';
        } else
          return null;
      },
      onSaved: (value) {
        widget.controller.text = value.toString();
      },
      keyboardType: widget.type,
      obscureText:
          widget.text == 'Password' || widget.text == 'Confirm Password'
              ? obs
              : false,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            if (widget.icon != null) {
              setState(() {
                obs = !obs;
                widget.icon = obs ? Icons.visibility_off : Icons.visibility;
              });
              print(obs);
            }
          },
          child: Icon(
            widget.icon != null
                ? obs
                    ? Icons.visibility_off
                    : Icons.visibility
                : null,
            color: Colors.grey,
          ),
        ),
        label: Text(widget.text),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 2, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(width: 2, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}
