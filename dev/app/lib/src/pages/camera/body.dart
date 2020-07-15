import 'dart:io';
import 'dart:ui';
import 'package:app/src/blocs/camera/index.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/camera/android/posts.dart';
import 'package:app/src/pages/camera/android/scanner.dart';
import 'package:app/src/pages/camera/apple/scanner.dart';
import 'package:app/src/pages/camera/ui/found.dart';
import 'package:app/src/pages/camera/ui/looking.dart';
import 'package:app/src/pages/camera/ui/no_ar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'
    show ArCoreController;

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isChecking = true;
  bool isARCoreAvaiable = false;

  @override
  void initState() {
    //isARCoreAvaiable = ArCoreController.checkArCoreAvailability();
    checkARCore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CameraBloc, CameraState>(
      listener: (context, state) {},
      child: BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) {
          return Stack(
            children: [
              (state is LookingForMarker || state is MarkerFound)
                  ? (Platform.isAndroid)
                      ? (isARCoreAvaiable) ? AndroidScanner() : Container()
                      : IOSScanner()
                  : AndroidPosts(),
              AnimatedOpacity(
                opacity:
                    (state is MarkerFound || state is PostsLoading) ? 1 : 0,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutExpo,
                child: Container(
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
              ),
              (isChecking || isARCoreAvaiable)
                  ? (state is LookingForMarker)
                      ? Looking()
                      : (state is MarkerFound || state is PostsLoading)
                          ? Found()
                          : Container()
                  : (!isARCoreAvaiable) ? NoAR() : Container()
            ],
          );
        },
      ),
    );
  }

  checkARCore() async {
    dynamic result = await ArCoreController.checkArCoreAvailability();
    setState(() {
      isARCoreAvaiable = result == 'true';
      isChecking = false;
    });
    print('Check ArCore Availability: $isARCoreAvaiable');
  }
}
