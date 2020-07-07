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

class Confirm extends StatefulWidget {
  Confirm({Key key}) : super(key: key);

  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  bool isValid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA92217),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopIconBack(
              icon: Icons.arrow_back,
              color: Colors.white,
            ),
            CText(
              'Welcome!',
              size: 32,
              weight: FontWeight.bold,
              hPadding: 24,
              top: 8,
              bottom: 24,
              color: Colors.white,
            ),
            Spacer(),
            Button(
              type: ButtonType.thirdStroke,
              dims: ButtonDims.large,
              label: 'Start Now',
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
            Padding(padding: const EdgeInsets.only(top: 24))
          ],
        ),
      ),
    );
  }
}
