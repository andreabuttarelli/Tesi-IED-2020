import 'package:app/src/blocs/accessibility/bloc.dart';
import 'package:app/src/blocs/feed/index.dart';
import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/blocs/theme/index.dart';

/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020

import 'package:flutter/material.dart';
import 'package:app/src/blocs/user/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './src/bloc_delegate.dart';
import './src/app.dart';
import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/blocs/navigation/bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  UserRepository userRepository = UserRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(userRepository: UserRepository())
                ..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
          create: (context) =>
              FeedBloc(httpClient: http.Client())..add(Fetch()),
        ),
        BlocProvider(
          create: (context) => LanguageBloc()..add(LanguageBlocStarted()),
        ),
        BlocProvider(
          create: (context) => AccessibilityBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc()
            ..add(SwitchTheme(
                theme: (MediaQuery.of(context).platformBrightness ==
                        Brightness.dark)
                    ? ThemeEnum.dark
                    : ThemeEnum.light)),
        ),
      ],
      child: App(),
    ),
  );
}
