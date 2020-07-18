import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class CameraEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateCameras extends CameraEvent {
  List<CameraDescription> cameras = [];

  UpdateCameras({this.cameras});
}
