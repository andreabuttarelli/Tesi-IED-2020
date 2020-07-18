import 'dart:io';

import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class NoAR extends StatelessWidget {
  const NoAR({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, Language>(
      builder: (context, lang) {
        return SafeArea(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopIconBack(
                    icon: FeatherIcons.x,
                    color: Colors.white,
                  ),
                ],
              ),
              Column(
                children: [
                  Spacer(),
                  Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 22),
                        child: Icon(
                          FeatherIcons.alertCircle,
                          size: 54,
                          color: Colors.white,
                        ),
                      ),
                      (Platform.isAndroid)
                          ? CText(
                              "${lang.script['noar_arcore']}",
                              size: 24,
                              weight: FontWeight.bold,
                              color: Palette.white,
                              hPadding: 24,
                              top: 24,
                              bottom: 24,
                            )
                          : CText(
                              "${lang.script['noar_arkit']}",
                              size: 24,
                              weight: FontWeight.bold,
                              color: Palette.white,
                              hPadding: 24,
                              top: 24,
                              bottom: 24,
                            ),
                    ],
                  ),
                  Spacer(),
                  Button(
                    label: "${lang.script['close']}",
                    color: Palette.accent,
                    dims: ButtonDims.large,
                    type: ButtonType.secondarySolid,
                    onClick: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
