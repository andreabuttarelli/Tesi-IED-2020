import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../objects/post.dart';

abstract class ARState extends Equatable {
  ARState();

  @override
  List<Object> get props => [];
}

class LookingForMarker extends ARState {}

class MarkerFound extends ARState {}

class PostsLoading extends ARState {}

class PostsError extends ARState {}

class PostsLoaded extends ARState {
  final List<Post> posts;
  PostsLoaded({@required this.posts});
}
