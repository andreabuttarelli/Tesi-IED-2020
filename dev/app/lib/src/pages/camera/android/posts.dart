import 'package:app/src/blocs/camera/bloc.dart';
import 'package:app/src/blocs/camera/event.dart';
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
  CameraBloc cameraBloc;

  @override
  void initState() {
    cameraBloc = BlocProvider.of<CameraBloc>(context);
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
      _addCube(arCoreController, vector.Vector3(-0.5, 0.5, 3.5)),
      _addCube(arCoreController, vector.Vector3(-1, -0.2, 2.0)),
      _addCube(arCoreController, vector.Vector3(3.1, 0.2, 1.5)),
      _addCube(arCoreController, vector.Vector3(1.5, 0.5, 1)),
      _addCube(arCoreController, vector.Vector3(0, -0.2, 3.5)),
      _addCube(arCoreController, vector.Vector3(2, 0.2, 1.5)),
    ]).then((List response) => confirm()).catchError((e) => print(e));
  }

  Future<bool> _addCube(
      ArCoreController controller, vector.Vector3 position) async {
    final ByteData textureBytes =
        await rootBundle.load('assets/square_picture.jpg');

    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = ArCoreNode(
      shape: cube,
      position: position,
    );
    controller.addArCoreNode(node);
    return true;
  }

  void confirm() {
    cameraBloc..add(ShowPosts());
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
