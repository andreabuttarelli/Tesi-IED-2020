import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';
import 'package:flutter/material.dart';

class EditorBloc extends Bloc<EditorEvent, List<Widget>> {
  List<Widget> list = [];
  EditorBloc();

  @override
  List<Widget> get initialState => [];

  @override
  Stream<List<Widget>> mapEventToState(EditorEvent event) async* {
    if (event is UpdateList) {
      yield event.list;
    }
    if (event is AddElement) {
      list.add(event.element);
      yield list;
    }
  }
}
