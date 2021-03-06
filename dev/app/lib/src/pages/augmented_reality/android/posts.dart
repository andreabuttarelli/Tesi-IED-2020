import 'package:app/src/blocs/augmented_reality/bloc.dart';
import 'package:app/src/blocs/augmented_reality/event.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:async';

class AndroidPosts extends StatefulWidget {
  @override
  _AndroidPostsState createState() => _AndroidPostsState();
}

class _AndroidPostsState extends State<AndroidPosts> {
  ArCoreController arCoreController;
  ARBloc cameraBloc;

  @override
  void initState() {
    cameraBloc = BlocProvider.of<ARBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) async {
    arCoreController = controller;

    await Future.wait([
      _addCube(arCoreController, vector.Vector3(-0.5, 0.5, 3.5), "image"),
      _addCube(arCoreController, vector.Vector3(-1, -0.2, 2.0), "image"),
      _addCube(arCoreController, vector.Vector3(3.1, 0.2, 1.5), "video"),
      _addCube(arCoreController, vector.Vector3(1.5, 0.5, 1), "image"),
      _addCube(arCoreController, vector.Vector3(0, -0.2, 3.5), "video"),
      _addCube(arCoreController, vector.Vector3(2, 0.2, 1.5), "image"),
    ]).then((List response) => confirm()).catchError((e) => print(e));
  }

  Future<bool> _addCube(
      ArCoreController controller, vector.Vector3 position, String type) async {
    final ByteData textureBytes = await rootBundle.load((type == "image")
        ? 'assets/ar/AR_image.jpg'
        : 'assets/ar/AR_video.jpg');

    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final cube = ArCoreSphere(
      materials: [material],
      radius: 0.3,
    );
    final node = ArCoreNode(
      shape: cube,
      position: position,
    );
    controller.addArCoreNode(node);
    return true;
  }

  void confirm() {
    cameraBloc..add(ReadyToShowPost());
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
