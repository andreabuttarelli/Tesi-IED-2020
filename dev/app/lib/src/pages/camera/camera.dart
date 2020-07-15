import 'dart:io';
import 'dart:ui';

import 'package:app/src/pages/camera/android/only_cam.dart';
import 'package:app/src/pages/camera/android/scanner.dart';
import 'package:flutter/material.dart';
import './body.dart';

class Camera extends StatefulWidget {
  Camera({Key key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  double opacity = 0;

  @override
  void initState() {
    opacity = 0;
    transition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Hero(
            tag: 'FAB',
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
            ),
          ),
          AnimatedOpacity(
            opacity: opacity,
            duration: Duration(milliseconds: 600),
            child: Body(),
          ),
        ],
      ),
    );
  }

  transition() async {
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      opacity = 1;
    });
  }
}
