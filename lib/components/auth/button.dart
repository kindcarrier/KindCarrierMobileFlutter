import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({@required this.title, @required this.onPress, this.width});

  final String title;
  final Function onPress;
  final double width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ButtonTheme(
      minWidth: this.width != null ? this.width : 0.8 * size.width,
      height: 50.0,
      child: RaisedButton(
        onPressed: this.onPress,
        color: Colors.orange,
        textColor: Colors.white,
        child: Text(
          this.title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
