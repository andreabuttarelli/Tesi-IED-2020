import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  Button({Key key}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 8),
      child: FlatButton(
        onPressed: () {},
        child: Container(
          child: Center(
            child: CText('Value',
                size: 12, color: Colors.white, weight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
