import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/design_system/textfield/textfield.dart';
import 'package:app/src/objects/validators.dart';
import 'package:app/src/pages/auth/registration/password/password.dart';
import 'package:app/src/pages/auth/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Email extends StatefulWidget {
  Email({Key key}) : super(key: key);

  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  bool isValid = false;
  int lenght = 0;
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
              setState(() {
                isValid = (!Validators.isValidEmail(text));
                lenght = text.length;
              });
            },
            isError: isValid,
            validationMessage: 'Write a valid email',
          ),
          Spacer(),
          AnimatedOpacity(
            opacity: (!isValid && lenght > 4) ? 1 : 0.5,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: IgnorePointer(
              ignoring: (isValid && lenght > 4),
              child: Button(
                color: Palette.accent,
                type: ButtonType.secondarySolid,
                dims: ButtonDims.large,
                label: 'Continue',
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Registration(
                        child: Password(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 24))
        ],
      ),
    );
  }
}
