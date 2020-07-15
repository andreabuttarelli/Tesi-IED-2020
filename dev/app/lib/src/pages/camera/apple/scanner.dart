import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class IOSScanner extends StatefulWidget {
  IOSScanner({Key key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<IOSScanner> {
  ArCoreController arCoreController;
  ARKitController arkitController;
  Map<int, ArCoreAugmentedImage> augmentedImagesMap = Map();

  @override
  Widget build(BuildContext context) {
    /*if (flagNavigation) {
      Navigator.pushNamed(context, '/Memories');
    }*/

    return Scaffold(
      body: ARKitSceneView(
        detectionImagesGroupName: 'AR Resources',
        onARKitViewCreated: onARKitViewCreated,
      ),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = onAnchorWasFound;
  }

  void onAnchorWasFound(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      Navigator.pushNamed(context, '/Memories');
    }
  }

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }
}
