import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/blocs/registration/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/design_system/textfield/textfield.dart';
import 'package:app/src/pages/auth/registration/confirm/confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Password extends StatefulWidget {
  Password({Key key}) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  RegisterBloc registerBloc;
  bool isValid = false;

  @override
  void initState() {
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return BlocBuilder<LanguageBloc, Language>(
          builder: (context, lang) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopIconBack(
                    icon: Icons.arrow_back,
                  ),
                  CText(
                    'Anyone has a little secret',
                    size: 32,
                    weight: FontWeight.bold,
                    hPadding: 24,
                    top: 8,
                    bottom: 24,
                  ),
                  CTextField(
                    title: 'Password',
                    placeholder: 'Enter password',
                    autofocus: true,
                    callBack: (String text) {
                      registerBloc..add(PasswordChanged(password: text));
                    },
                    isError: isValid,
                    validationMessage: 'Must be at least 6 characters',
                  ),
                  Spacer(),
                  Button(
                    color: Palette.accent,
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
          },
        );
      },
    );
  }
}
