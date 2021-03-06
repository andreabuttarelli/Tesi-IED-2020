import 'package:app/src/blocs/authentication/index.dart';
import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/blocs/login/index.dart';
import 'package:app/src/blocs/user/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/top_icon_back.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/design_system/textfield/textfield.dart';
import 'package:app/src/pages/auth/login/google_button.dart';
import 'package:app/src/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  final Widget destination;
  Body({Key key, this.destination}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  LoginBloc loginBloc;
  String email, password;

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print(state);
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          BlocProvider.of<UserBloc>(context).add(UserLogged());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<LanguageBloc, Language>(
        builder: (context, lang) {
          return NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
              child: SafeArea(
                bottom: false,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopIconBack(
                        icon: Icons.arrow_back,
                        color: Colors.black,
                      ),
                      CText(
                        'Bentornato',
                        size: 32,
                        weight: FontWeight.bold,
                        hPadding: 24,
                        top: 0,
                        bottom: 24,
                      ),
                      CTextField(
                        title: 'Email',
                        placeholder: 'Enter email',
                        autofocus: true,
                        callBack: (text) {
                          setState(() {
                            email = text;
                          });
                          loginBloc..add(EmailChanged(email: text));
                        },
                      ),
                      CTextField(
                        title: 'Password',
                        placeholder: 'Enter password',
                        secure: true,
                        callBack: (text) {
                          setState(() {
                            password = text;
                          });
                          loginBloc..add(PasswordChanged(password: text));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 54),
                      ),
                      GoogleSignInButton(
                        onClick: () {
                          loginBloc..add(LoginWithGooglePressed());
                        },
                      ),
                      Button(
                        color: Palette.accent,
                        type: ButtonType.secondarySolid,
                        dims: ButtonDims.large,
                        label: 'Login',
                        onClick: () {
                          loginBloc
                            ..add(
                              LoginWithCredentialsPressed(
                                email: email,
                                password: password,
                              ),
                            );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
