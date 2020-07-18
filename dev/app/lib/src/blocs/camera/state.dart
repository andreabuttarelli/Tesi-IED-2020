import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class CameraState extends Equatable {
  CameraState();

  @override
  List<Object> get props => [];
}

class Undefined extends CameraState {}

class Avaiable extends CameraState {
  List<CameraDescription> cameras = [];

  Avaiable({this.cameras});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Avaiable { n. camera(s): ${cameras.length} }';
}
