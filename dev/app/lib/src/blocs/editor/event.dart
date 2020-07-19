import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class EditorEvent extends Equatable {
  EditorEvent();

  @override
  List<Object> get props => [];
}

class UpdateList extends EditorEvent {
  List<Widget> list;

  UpdateList(this.list);
}

class AddElement extends EditorEvent {
  Widget element;

  AddElement(this.element);
}

class RemoveElement extends EditorEvent {}
