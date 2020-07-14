import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/blocs/login/bloc.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './body.dart';

class Login extends StatelessWidget {
  final Widget destination;
  const Login({Key key, this.destination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          (MediaQuery.of(context).platformBrightness == Brightness.dark)
              ? DarkPalette().colors["${Palette.backgroundPrimary}"]
              : LightPalette().colors["${Palette.backgroundPrimary}"],
      body: BlocProvider(
        create: (context) => LoginBloc(userRepository: UserRepository()),
        child: Body(),
      ),
    );
  }
}
