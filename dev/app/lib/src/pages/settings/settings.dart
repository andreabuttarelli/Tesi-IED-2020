import 'package:app/src/blocs/alert/index.dart';
import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/pages/settings/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './body.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  AuthenticationBloc authenticationBloc;
  bool isVisible = false;

  @override
  void initState() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlertBloc(),
      child: Scaffold(
        body: BlocBuilder<AlertBloc, bool>(
          builder: (context, flagVisible) {
            /*if (flagVisible)
              setState(() {
                isVisible = true;
              });
            else
              hideAlert();*/

            return Stack(
              children: [
                Body(),
                Visibility(
                  visible: (flagVisible) ? true : isVisible,
                  child: AnimatedOpacity(
                    opacity: (flagVisible) ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    child: Alert(
                      cta: "Exit",
                      function: () {
                        authenticationBloc..add(LoggedOut());
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  hideAlert() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      isVisible = false;
    });
  }
}
