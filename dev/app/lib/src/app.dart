import 'package:app/src/pages/auth/pre_login.dart';
import 'package:app/src/pages/splash/splash.dart';
/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/pages/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/src/blocs/user/index.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  UserBloc userBloc;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/Logo-min.jpg"), context);
    return MaterialApp(
      title: 'Onda Gamma',
      theme: ThemeData(fontFamily: 'Gilroy'),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticated) {
            userBloc.add(UserLogged());
            return Home();
          }
          if (state is Unauthenticated) {
            return PreLogin();
          }
          return Splash();
        },
      ),
    );
  }
}