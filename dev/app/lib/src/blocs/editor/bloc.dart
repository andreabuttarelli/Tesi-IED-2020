import 'dart:async';
import 'package:app/src/objects/place.dart';
import 'package:bloc/bloc.dart';
import './index.dart';
import 'package:flutter/material.dart';

class EditorBloc extends Bloc<EditorEvent, Place> {
  EditorBloc();

  @override
  Place get initialState => Place();

  @override
  Stream<Place> mapEventToState(EditorEvent event) async* {
    if (event is Update) yield event.place;
  }
}
