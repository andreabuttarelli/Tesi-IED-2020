import 'package:flutter/material.dart';
import './body.dart';

class Camera extends StatelessWidget {
  const Camera({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}
