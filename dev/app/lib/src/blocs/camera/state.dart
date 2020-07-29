import 'package:equatable/equatable.dart';

abstract class CameraState extends Equatable {
  CameraState();

  @override
  List<Object> get props => [];
}

class Undefined extends CameraState {}

class Content extends CameraState {
  final String url;
  final bool isImage;
  final bool isSaved;

  Content({this.url, this.isImage, this.isSaved});

  String toString() => 'Content { url: $url, isImage: $isImage }';
}
