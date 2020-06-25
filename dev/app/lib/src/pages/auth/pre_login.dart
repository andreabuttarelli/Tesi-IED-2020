import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';

class PreLogin extends StatelessWidget {
  const PreLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Column(children: [
      Spacer(),
      CText('Parco Archeologico del Colosseo'),
      Spacer(),
      Button(label: 'Login', type: ButtonType.secondarySolid, dims: ButtonDims.large,),
      Button(label: 'Join Now', type: ButtonType.primaryStroke, dims: ButtonDims.large,),
    ],),));
  }
}