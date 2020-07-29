import 'package:bloc/bloc.dart';
import 'package:app/src/repositories/user.dart';
import 'package:app/src/objects/user.dart';
import 'dart:async';
import './index.dart';

class UserBloc extends Bloc<UserEvent, UserObject> {
  UserBloc();

  @override
  UserObject get initialState => null;

  @override
  Stream<UserObject> mapEventToState(UserEvent event) async* {
    if (event is UserLogged) {
      //UserRepository repository;
      //yield await repository.getCurrentUserObject();
    }
  }
}
