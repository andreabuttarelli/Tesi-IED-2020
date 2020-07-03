import 'package:flutter/material.dart';
import './email/email.dart';

class Registration extends StatelessWidget {
  final Widget child;
  const Registration({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
