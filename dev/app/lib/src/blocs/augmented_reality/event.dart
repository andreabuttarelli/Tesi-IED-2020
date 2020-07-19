import 'package:equatable/equatable.dart';

abstract class AREvent extends Equatable {
  AREvent();

  @override
  List<Object> get props => [];
}

class LoadPosts extends AREvent {}

class ReadyToShowPost extends AREvent {}

class ShowPosts extends AREvent {}

class OpenCamera extends AREvent {}
