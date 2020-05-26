import 'dart:async';
import 'package:app/src/repositories/user.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import './index.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository}) : assert(userRepository != null), _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Unitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      Future.delayed(const Duration(seconds: 1));
      final isSignedIn = await _userRepository.isSignedIn();
      if(isSignedIn) {
        final id = await _userRepository.getIdUser();
        yield Authenticated(id);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final id = await _userRepository.getIdUser();
    yield Authenticated(id);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}