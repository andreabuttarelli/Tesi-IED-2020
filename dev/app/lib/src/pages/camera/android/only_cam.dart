import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';

class OnlyCamAndroid extends StatefulWidget {
  OnlyCamAndroid({Key key}) : super(key: key);

  @override
  _OnlyCamAndroidState createState() => _OnlyCamAndroidState();
}

class _OnlyCamAndroidState extends State<OnlyCamAndroid> {
  ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return ArCoreView(
      onArCoreViewCreated: _onArCoreViewCreated,
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
