import 'dart:ui';

import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, Language>(
      builder: (context, lang) {
        return SafeArea(
          child: ListView(
            children: [
              Row(
                children: [
                  TopIconBack(
                    icon: Icons.arrow_back,
                    color: Colors.white,
                  ),
                ],
              ),
              BlocBuilder<LanguageBloc, Language>(
                builder: (context, lang) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CText(
                        '${lang.script["camera_title"]}',
                        size: 32,
                        weight: FontWeight.bold,
                        color: Colors.white,
                        hPadding: 24,
                        top: 24,
                        bottom: 24,
                      ),
                    ],
                  );
                },
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 0,
                  ),
                  width: double.maxFinite,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black.withOpacity(0.0), width: 0),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: BlocBuilder<LanguageBloc, Language>(
                      builder: (context, lang) {
                        return CText(
                          '${lang.script["camera_inside"]}',
                          size: 24,
                          weight: FontWeight.bold,
                          hPadding: 0,
                          top: 0,
                          bottom: 0,
                        );
                      },
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  padding: const EdgeInsets.all(24),
                  width: double.maxFinite,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Color(0xFFf1f1f1),
                    border: Border.all(
                        color: Colors.black.withOpacity(0.0), width: 0),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: BlocBuilder<LanguageBloc, Language>(
                      builder: (context, lang) {
                        return CText(
                          '${lang.script["camera_outside"]}',
                          size: 24,
                          weight: FontWeight.bold,
                          hPadding: 0,
                          top: 0,
                          bottom: 0,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
