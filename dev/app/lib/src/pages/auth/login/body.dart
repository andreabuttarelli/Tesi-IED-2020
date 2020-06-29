import 'package:app/src/blocs/login/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/design_system/textfield/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state == LoginState.loading()) {}
        if (state == LoginState.success()) {}
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SafeArea(
            bottom: false,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopIconBack(
                    icon: Icons.arrow_back,
                    color: Colors.black,
                  ),
                  CText(
                    'Bentornato',
                    size: 32,
                    weight: FontWeight.bold,
                    hPadding: 24,
                    top: 0,
                    bottom: 24,
                  ),
                  CTextField(
                    title: 'Email',
                    placeholder: 'Enter email',
                    autofocus: true,
                    isError: state.isEmailValid,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
