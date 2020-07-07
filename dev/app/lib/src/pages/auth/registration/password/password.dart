import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/design_system/textfield/textfield.dart';
import 'package:app/src/objects/validators.dart';
import 'package:app/src/pages/auth/registration/confirm/confirm.dart';
import 'package:app/src/pages/auth/registration/registration.dart';
import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  Password({Key key}) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool isValid = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopIconBack(
            icon: Icons.arrow_back,
            color: Colors.black,
          ),
          CText(
            'Nice to meet you!',
            size: 32,
            weight: FontWeight.bold,
            hPadding: 24,
            top: 8,
            bottom: 24,
          ),
          CTextField(
            title: 'Email',
            placeholder: 'Enter email',
            autofocus: true,
            callBack: (String text) {
              print(!Validators.isValidEmail(text));
              setState(() {
                isValid = !Validators.isValidEmail(text);
              });
            },
            isError: isValid,
            validationMessage: 'Write a valid email',
          ),
          Spacer(),
          Button(
            type: ButtonType.secondarySolid,
            dims: ButtonDims.large,
            label: 'Continue',
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Confirm(),
                ),
              );
            },
          ),
          Padding(padding: const EdgeInsets.only(top: 24))
        ],
      ),
    );
  }
}
