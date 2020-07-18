import 'dart:async';
import 'package:app/src/blocs/position/index.dart';
import 'package:app/src/objects/place.dart';
import 'package:app/src/repositories/position.dart';
import 'package:bloc/bloc.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  List<Place> places = [];
  PositionBloc();

  @override
  PositionState get initialState => Null();

  @override
  Stream<PositionState> mapEventToState(PositionEvent event) async* {
    if (event is UpdatePosition) {
      if (places.length == 0) {
        places = await PositionRepository().getAllPlaces();
      }
      final nextState = await PositionRepository()
          .findNearest(myPosition: event.geopoint, places: places);
      yield nextState;
    }
  }
}
