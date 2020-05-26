import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/repositories/user.dart';
/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020

import 'package:flutter/material.dart';
import 'package:app/src/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/src/blocs/first_time/index.dart';
import './src/bloc-delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
        ),
        BlocProvider(
          create: (BuildContext context) => FirstTimeBloc()..add(Started()),
        )
      ],
      child: App(),
    )
  );
}
