import 'package:app/src/blocs/alert/index.dart';
import 'package:app/src/blocs/authentication/bloc.dart';
import 'package:app/src/blocs/authentication/event.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutAlert extends StatefulWidget {
  LogoutAlert({Key key}) : super(key: key);

  @override
  _LogoutAlertState createState() => _LogoutAlertState();
}

class _LogoutAlertState extends State<LogoutAlert> {
  AlertBloc alertBloc;
  AuthenticationBloc authBloc;
  @override
  void initState() {
    alertBloc = BlocProvider.of<AlertBloc>(context);
    authBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(
              'Are you sure?',
              size: 32,
              color: Colors.black,
              weight: FontWeight.bold,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48),
            ),
            Button(
              type: ButtonType.primarySolid,
              dims: ButtonDims.medium,
              label: 'Exit',
              onClick: () {
                alertBloc..add(Hide());
                authBloc..add(LoggedOut());
              },
            ),
          ],
        ),
      ),
    );
  }
}
