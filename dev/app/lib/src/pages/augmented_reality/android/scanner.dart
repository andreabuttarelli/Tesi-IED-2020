import 'dart:async';

import 'package:app/src/blocs/augmented_reality/index.dart';
import 'package:app/src/blocs/token/index.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AndroidScanner extends StatefulWidget {
  AndroidScanner({Key key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<AndroidScanner> {
  ArCoreController arCoreController;
  Map<int, ArCoreAugmentedImage> augmentedImagesMap = Map();
  ARBloc cameraBloc;
  TokenBloc tokenBloc;

  @override
  void initState() {
    cameraBloc = BlocProvider.of<ARBloc>(context);
    tokenBloc = BlocProvider.of<TokenBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*if (flagNavigation) {
      Navigator.pushNamed(context, '/Memories');
    }*/

    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        type: ArCoreViewType.AUGMENTEDIMAGES,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onTrackingImage = _handleOnTrackingImage;
    loadSingleImage();
  }

  loadSingleImage() async {
    final ByteData bytes =
        await rootBundle.load('assets/earth_augmented_image.jpg');
    arCoreController.loadSingleAugmentedImage(
        bytes: bytes.buffer.asUint8List());
  }

  /*loadImagesDatabase() async {
    final ByteData bytes = await rootBundle.load('assets/myimages.imgdb');
    arCoreController.loadAugmentedImagesDatabase(
        bytes: bytes.buffer.asUint8List());
  }*/

  _handleOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    if (!augmentedImagesMap.containsKey(augmentedImage.index)) {
      augmentedImagesMap[augmentedImage.index] = augmentedImage;
      tempListen();
      //Navigator.pushNamed(context, '/Memories');
    }
  }

  tempListen() async {
    //only with simulators
    Position position = Position(latitude: 41.8853658, longitude: 12.4966204);
    await Future.delayed(Duration(milliseconds: 400));
    tokenBloc
      ..add(UpdateTokenPosition(geopoint: GeoPoint(41.8853658, 12.4966204)));
    goForward();
  }

  listen() async {
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    StreamSubscription<Position> positionStream =
        geolocator.getPositionStream(locationOptions).listen(
      (Position position) {
        tokenBloc
          ..add(UpdateTokenPosition(
              geopoint: GeoPoint(position.latitude, position.longitude)));
      },
    );
  }

  goForward() {
    cameraBloc..add(LoadPosts());
  }

  /*Future _addSphere(ArCoreAugmentedImage augmentedImage) async {
    final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 1,
    );
    final node = ArCoreNode(shape: sphere);
    final node1 = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    final node2 = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(1, 0, 0),
    );
    final node3 = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0.3, -0.3, 0),
    );
    //arCoreController.addArCoreNodeToAugmentedImage(node, augmentedImage.index);
    arCoreController.addArCoreNode(node);
    arCoreController.addArCoreNode(node1);
    arCoreController.addArCoreNode(node2);
    arCoreController.addArCoreNode(node3);
  }*/

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
