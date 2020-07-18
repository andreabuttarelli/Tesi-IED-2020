import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Looking extends StatefulWidget {
  Looking({Key key}) : super(key: key);

  @override
  _LookingState createState() => _LookingState();
}

class _LookingState extends State<Looking> {
  bool theme;
  bool isFound = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return BlocBuilder<LanguageBloc, Language>(
      builder: (context, lang) {
        return Stack(
          children: [
            Container(
              child: Center(
                child: ClipPath(
                  clipper: InvertedCircleClipper(),
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TopIconBack(
                        icon: FeatherIcons.x,
                        color: Colors.white,
                      ),
                      TopIcon(
                        icon: FeatherIcons.helpCircle,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CText(
                        'Scanner the marker',
                        size: 32,
                        weight: FontWeight.bold,
                        color: Palette.white,
                        hPadding: 24,
                        top: 24,
                        bottom: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return new Path()
      ..addOval(new Rect.fromCircle(
          center: new Offset(size.width / 2, size.height / 2),
          radius: size.width * 0.45))
      ..addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
