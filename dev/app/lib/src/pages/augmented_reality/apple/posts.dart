import 'package:app/src/blocs/augmented_reality/bloc.dart';
import 'package:app/src/blocs/augmented_reality/event.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:arkit_plugin/widget/arkit_scene_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:async';

class IOSPosts extends StatefulWidget {
  @override
  _IOSPostsState createState() => _IOSPostsState();
}

class _IOSPostsState extends State<IOSPosts> {
  ARKitController arKitController;
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
        body: ARKitSceneView(
          onARKitViewCreated: _onArKitViewCreated,
        ),
      ),
    );
  }

  void _onArKitViewCreated(ARKitController controller) async {
    arKitController = controller;

    await Future.wait([
      _addCube(arKitController, vector.Vector3(-0.5, 0.5, 3.5), "image"),
      _addCube(arKitController, vector.Vector3(-1, -0.2, 2.0), "image"),
      _addCube(arKitController, vector.Vector3(3.1, 0.2, 1.5), "video"),
      _addCube(arKitController, vector.Vector3(1.5, 0.5, 1), "image"),
      _addCube(arKitController, vector.Vector3(0, -0.2, 3.5), "video"),
      _addCube(arKitController, vector.Vector3(2, 0.2, 1.5), "image"),
    ]).then((List response) => confirm()).catchError((e) => print(e));
  }

  Future<bool> _addCube(
      ARKitController controller, vector.Vector3 position, String type) async {
    final material = ARKitMaterial(
        diffuse: ARKitMaterialProperty(
            image: (type == "image")
                ? 'assets/ar/AR_image.jpg'
                : 'assets/ar/AR_video.jpg'));
    final cube = ARKitSphere(
      materials: [material],
      radius: 0.3,
    );
    final node = ARKitNode(
      geometry: cube,
      position: position,
    );
    controller.add(node);
    return true;
  }

  void confirm() {
    cameraBloc..add(ReadyToShowPost());
  }

  @override
  void dispose() {
    arKitController.dispose();
    super.dispose();
  }
}
