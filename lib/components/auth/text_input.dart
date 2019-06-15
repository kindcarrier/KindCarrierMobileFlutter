import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final bool obscureText;
  final Function onSaved;
  final Function validator;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;

  TextInput({
    this.obscureText,
    @required this.validator,
    @required this.onSaved,
    this.hintText,
    this.labelText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText != null ? obscureText : false,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xefefef),
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Color(0xefefef),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
