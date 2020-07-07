import 'package:app/src/blocs/alert/index.dart';
import 'package:app/src/blocs/authentication/bloc.dart';
import 'package:app/src/blocs/authentication/event.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Alert extends StatefulWidget {
  Function function;
  String cta;
  Alert({
    Key key,
    this.function,
    this.cta,
  }) : super(key: key);

  @override
  _LogoutAlertState createState() => _LogoutAlertState();
}

class _LogoutAlertState extends State<Alert> {
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        alertBloc..add(Hide());
      },
      child: Container(
        color: Colors.black38,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(vertical: 24),
              height: 340,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CText(
                      'Are you sure?',
                      size: 32,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Button(
                    type: ButtonType.secondarySolid,
                    dims: ButtonDims.large,
                    label: '${widget.cta}',
                    onClick: () {
                      alertBloc..add(Hide());
                      widget.function;
                    },
                  ),
                  Button(
                    type: ButtonType.primaryStroke,
                    dims: ButtonDims.large,
                    label: 'Cancel',
                    onClick: () {
                      alertBloc..add(Hide());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
