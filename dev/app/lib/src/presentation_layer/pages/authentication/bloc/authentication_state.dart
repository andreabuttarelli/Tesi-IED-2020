/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationState';
}

class Unitialized extends AuthenticationState {}