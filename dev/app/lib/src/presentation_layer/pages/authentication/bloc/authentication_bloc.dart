/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020

import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'index.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc();

  @override
  AuthenticationState get initialState => Unitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {

  }
}