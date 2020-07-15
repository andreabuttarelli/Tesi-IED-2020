import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../objects/post.dart';

abstract class CameraState extends Equatable {
  CameraState();

  @override
  List<Object> get props => [];
}

class LookingForMarker extends CameraState {}

class MarkerFound extends CameraState {}

class PostsLoading extends CameraState {}

class PostsError extends CameraState {}

class PostsLoaded extends CameraState {
  final List<Post> posts;
  PostsLoaded({@required this.posts});
}
