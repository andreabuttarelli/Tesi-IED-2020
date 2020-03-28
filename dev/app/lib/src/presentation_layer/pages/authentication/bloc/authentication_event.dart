/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationEvent';
}