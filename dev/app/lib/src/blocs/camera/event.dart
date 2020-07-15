import 'package:app/src/pages/camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class CameraEvent extends Equatable {
  CameraEvent();

  @override
  List<Object> get props => [];
}

class LoadPosts extends CameraEvent {}

class ShowPosts extends CameraEvent {}

class OpenCamera extends CameraEvent {}
