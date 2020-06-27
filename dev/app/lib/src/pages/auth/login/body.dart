import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/design_system/textfield/textfield.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopIcon(
            icon: Icons.arrow_back,
            color: Colors.black,
          ),
          CText(
            'Login',
            size: 32,
            weight: FontWeight.bold,
            hPadding: 24,
            top: 8,
            bottom: 24,
          ),
          CTextField(
            title: 'Email',
            placeholder: 'Enter email',
          ),
          CTextField(
            title: 'Password',
            placeholder: 'Enter password',
            secure: true,
          ),
          Spacer(),
          Button(
            type: ButtonType.secondarySolid,
            dims: ButtonDims.large,
            label: 'Login',
          ),
          Padding(padding: const EdgeInsets.only(top: 24))
        ],
      ),
    );
  }
}
