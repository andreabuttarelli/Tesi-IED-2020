import 'package:equatable/equatable.dart';
import 'package:webfeed/domain/atom_item.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedUninitialized extends FeedState {}

class FeedError extends FeedState {}

class FeedLoaded extends FeedState {
  final List<AtomItem> posts;
  final bool hasReachedMax;

  const FeedLoaded({
    this.posts,
    this.hasReachedMax,
  });

  FeedLoaded copyWith({
    List<AtomItem> posts,
    bool hasReachedMax,
  }) {
    return FeedLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];

  @override
  String toString() =>
      'FeedLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}
