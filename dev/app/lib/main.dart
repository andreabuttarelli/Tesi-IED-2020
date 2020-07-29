import 'package:app/src/blocs/accessibility/bloc.dart';
import 'package:app/src/blocs/augmented_reality/bloc.dart';
import 'package:app/src/blocs/camera/bloc.dart';
import 'package:app/src/blocs/feed/index.dart';
import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/blocs/new_note/index.dart';
import 'package:app/src/blocs/position/bloc.dart';
import 'package:app/src/blocs/position/event.dart';
import 'package:flutter/material.dart';
import 'package:app/src/blocs/user/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import './src/bloc_delegate.dart';
import './src/app.dart';
import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/blocs/navigation/bloc.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocSupervisor.delegate = SimpleBlocDelegate();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
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
          create: (context) => ARBloc(),
        ),
        BlocProvider(
          create: (context) => CameraBloc(),
        ),
        BlocProvider(
          create: (context) => PositionBloc()..add(UpdatePosition()),
        ),
        BlocProvider(
          create: (context) => NewNoteBloc()..add(FetchPlaces()),
        ),
      ],
      child: App(),
    ),
  );
}
