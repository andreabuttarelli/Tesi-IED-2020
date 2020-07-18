import 'dart:async';
import 'package:app/src/blocs/token/index.dart';
import 'package:app/src/objects/place.dart';
import 'package:app/src/repositories/token.dart';
import 'package:bloc/bloc.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  List<Place> places = [];
  TokenBloc();

  @override
  TokenState get initialState => Null();

  @override
  Stream<TokenState> mapEventToState(TokenEvent event) async* {
    if (event is UpdateTokenPosition) {
      if (places.length == 0) {
        places = await TokenRepository().getAllTokens();
      }
      final nextState = await TokenRepository()
          .findNearest(myPosition: event.geopoint, places: places);
      yield nextState;
    }
  }
}
