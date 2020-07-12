import 'dart:io';
import 'dart:ui';

import 'package:app/src/pages/camera/android/only_cam.dart';
import 'package:flutter/material.dart';
import './body.dart';

class Camera extends StatefulWidget {
  Camera({Key key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (Platform.isAndroid) ? OnlyCamAndroid() : Container(),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.54),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white30,
              ),
            ),
          ),
          Body(),
        ],
      ),
    );
  }
}
