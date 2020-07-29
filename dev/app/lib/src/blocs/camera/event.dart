import 'package:equatable/equatable.dart';

abstract class CameraEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Take extends CameraEvent {
  final String url;
  final bool isImage;

  Take({this.url, this.isImage});
}

class Save extends CameraEvent {}

class Send extends CameraEvent {}
