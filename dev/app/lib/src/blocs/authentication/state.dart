import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Unitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String id;

  const Authenticated(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Authenticated { id: $id }';
}

class Unauthenticated extends AuthenticationState {}