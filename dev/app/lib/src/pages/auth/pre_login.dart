import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/design_system/textfield/textfield.dart';
import 'package:app/src/pages/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class PreLogin extends StatelessWidget {
  const PreLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopIconBack(
            icon: FeatherIcons.arrowLeft,
          ),
          Spacer(),
          CText('Parco Archeologico del Colosseo'),
          Spacer(),
          CTextField(
            title: "Email",
            isError: false,
            validationMessage: "message",
          ),
          Button(
            label: 'Login',
            type: ButtonType.secondarySolid,
            dims: ButtonDims.large,
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
          Button(
            label: 'Join Now',
            type: ButtonType.primaryStroke,
            dims: ButtonDims.large,
          ),
        ],
      ),
    ));
  }
}
