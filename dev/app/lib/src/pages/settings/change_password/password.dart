import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/top_icon.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/design_system/textfield/textfield.dart';
import 'package:app/src/objects/validators.dart';
import 'package:app/src/pages/auth/registration/password/password.dart';
import 'package:app/src/pages/auth/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../confirm/confirm.dart';

class Password extends StatefulWidget {
  Password({Key key}) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool isValid = false;
  int lenght = 0;
  String email = '';

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
            'Change Password',
            size: 32,
            weight: FontWeight.bold,
            hPadding: 24,
            top: 8,
            bottom: 24,
          ),
          CTextField(
            title: 'Enter Email',
            placeholder: 'Enter email',
            autofocus: true,
            callBack: (String text) {
              setState(() {
                email = text;
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
                type: ButtonType.secondarySolid,
                dims: ButtonDims.large,
                label: 'Continue',
                onClick: () async {
                  var result = true;
                  //await UserRepository().changePassword(email: email);
                  if (result)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Confirm(
                          title: 'Well done!',
                          subtitle:
                              'We have sent you an email to change the password',
                          cta: 'Come back home',
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