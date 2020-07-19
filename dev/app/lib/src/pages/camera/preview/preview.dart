import 'package:flutter/material.dart';
import './body.dart';

class Preview extends StatelessWidget {
  const Preview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
