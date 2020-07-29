import 'package:app/src/blocs/language/bloc.dart';
import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/blocs/registration/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/design_system/textfield/textfield.dart';
import 'package:app/src/pages/auth/registration/password/password.dart';
import 'package:app/src/pages/auth/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Name extends StatefulWidget {
  Name({Key key}) : super(key: key);

  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Name> {
  bool isValid = false;
  int lenght = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return BlocBuilder<LanguageBloc, Language>(
          builder: (context, lang) {
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
                    title: "What's your name?",
                    placeholder: 'Enter your full name',
                    autofocus: true,
                    callBack: (String text) {
                      setState(() {
                        lenght = text.length;
                      });
                    },
                    isError: state.isEmailValid,
                    validationMessage: "Does not seem like a valid name",
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
          },
        );
      },
    );
  }
}
