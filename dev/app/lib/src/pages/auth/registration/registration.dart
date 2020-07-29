import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/blocs/registration/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Registration extends StatelessWidget {
  final Widget child;
  const Registration({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contex) => RegisterBloc(userRepository: UserRepository()),
      child: Scaffold(
        backgroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.dark)
                ? DarkPalette().colors["${Palette.backgroundPrimary}"]
                : LightPalette().colors["${Palette.backgroundPrimary}"],
        body: child,
      ),
    );
  }
}
