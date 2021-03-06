import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/design_system/textfield/textfield.dart';
import 'package:app/src/objects/validators.dart';
import 'package:flutter/material.dart';
import '../confirm/confirm.dart';

class Email extends StatefulWidget {
  Email({Key key}) : super(key: key);

  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  bool isValid = false;
  int lenght = 0;
  String password = '';
  String email = '';
  bool theme;

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopIconBack(
            icon: Icons.arrow_back,
            color: (!theme)
                ? LightPalette().colors["Palette.textPrimary"]
                : DarkPalette().colors["Palette.textPrimary"],
          ),
          CText(
            'Change Email',
            size: 32,
            weight: FontWeight.bold,
            hPadding: 24,
            top: 8,
            bottom: 24,
          ),
          CTextField(
            title: 'New Email',
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
          CTextField(
            title: 'Password',
            placeholder: 'Enter password',
            autofocus: true,
            callBack: (String text) {
              setState(() {
                password = text;
              });
            },
            isError: isValid,
            validationMessage: 'Write a valid email',
          ),
          Spacer(),
          AnimatedOpacity(
            opacity: (!isValid && lenght > 4 && password.length > 5) ? 1 : 0.5,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: IgnorePointer(
              ignoring: (isValid && lenght > 4 && password.length > 5),
              child: Button(
                color: Palette.textAccent,
                type: ButtonType.secondarySolid,
                dims: ButtonDims.large,
                label: 'Continue',
                onClick: () async {
                  var result = await UserRepository()
                      .changeEmail(email: email, password: password);
                  if (result)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Confirm(
                          title: 'Well done!',
                          subtitle: 'We have sent you an info email',
                          cta: 'Come back home',
                        ),
                      ),
                    );
                  else {
                    print("wrong credentials");
                  }
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
