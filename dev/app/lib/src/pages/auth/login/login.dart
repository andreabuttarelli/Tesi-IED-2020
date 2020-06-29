import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/blocs/login/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './body.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(userRepository: UserRepository()),
        child: Body(),
      ),
    );
  }
}
