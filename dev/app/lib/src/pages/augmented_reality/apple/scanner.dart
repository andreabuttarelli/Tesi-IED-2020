import 'dart:async';

import 'package:app/src/blocs/augmented_reality/index.dart';
import 'package:app/src/blocs/token/index.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class IOSScanner extends StatefulWidget {
  IOSScanner({Key key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<IOSScanner> {
  ARKitController arkitController;
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
      tempListen();
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

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }
}
