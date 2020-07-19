import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class CameraState extends Equatable {
  CameraState();

  @override
  List<Object> get props => [];
}

class Undefined extends CameraState {}

class Content extends CameraState {
  String url;
  bool isImage;
  bool isSaved;

  Content({this.url, this.isImage, this.isSaved});

  String toString() => 'Content { url: $url, isImage: $isImage }';
}
