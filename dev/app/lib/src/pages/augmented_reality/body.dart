import 'dart:io';
import 'dart:ui';
import 'package:app/src/blocs/augmented_reality/index.dart';
import 'package:app/src/blocs/token/bloc.dart';
import 'package:app/src/blocs/token/state.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/augmented_reality/android/posts.dart';
import 'package:app/src/pages/augmented_reality/android/scanner.dart';
import 'package:app/src/pages/augmented_reality/apple/posts.dart';
import 'package:app/src/pages/augmented_reality/apple/scanner.dart';
import 'package:app/src/pages/augmented_reality/ui/before_cam.dart';
import 'package:app/src/pages/augmented_reality/ui/found.dart';
import 'package:app/src/pages/augmented_reality/ui/looking.dart';
import 'package:app/src/pages/augmented_reality/ui/no_ar.dart';
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
  bool isChecking = false;
  bool isARCoreAvaiable = true;

  @override
  void initState() {
    //isARCoreAvaiable = ArCoreController.checkArCoreAvailability();
    //checkARCore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ARBloc, ARState>(
      listener: (context, state) {},
      child: BlocBuilder<ARBloc, ARState>(
        builder: (context, state) {
          return Stack(
            children: [
              (state is LookingForMarker || state is MarkerFound)
                  ? (Platform.isAndroid) ? AndroidScanner() : IOSScanner()
                  : (Platform.isAndroid) ? AndroidPosts() : IOSPosts(),
              BlocBuilder<TokenBloc, TokenState>(
                builder: (context, tokenState) {
                  return AnimatedOpacity(
                    opacity:
                        (state is MarkerFound || state is PostsLoading) ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutExpo,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black
                          .withOpacity((tokenState is PlaceFound) ? 1 : 0.54),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.white30,
                        ),
                      ),
                    ),
                  );
                },
              ),
              (isChecking || isARCoreAvaiable)
                  ? (state is LookingForMarker)
                      ? Looking()
                      : (state is MarkerFound || state is PostsLoading)
                          ? Found()
                          : BeforeCamera()
                  : (!isARCoreAvaiable) ? NoAR() : Container()
            ],
          );
        },
      ),
    );
  }

  checkARCore() {
    /*dynamic result = await ArCoreController.checkArCoreAvailability();

    setState(() {
      isARCoreAvaiable = result == 'true';
      isChecking = false;
    });
    print('Check ArCore Availability: $isARCoreAvaiable');*/
  }
}
