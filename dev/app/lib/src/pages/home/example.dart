import 'package:app/src/blocs/theme/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Example extends StatelessWidget {
  const Example({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Center(
          child: CText(
            'Ciao',
            size: 20,
            weight: FontWeight.w700,
            color: Palette.textSecondary70,
          ),
        ),
      ),
    );
  }
}
