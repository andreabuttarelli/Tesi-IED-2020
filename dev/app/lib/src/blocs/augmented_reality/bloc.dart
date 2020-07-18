import 'dart:async';
import 'package:app/src/objects/post.dart';
import 'package:bloc/bloc.dart';
import './index.dart';

class ARBloc extends Bloc<AREvent, ARState> {
  bool readyToShowPosts = false;
  List<Post> posts = [];

  ARBloc();

  @override
  ARState get initialState => LookingForMarker();

  @override
  Stream<ARState> mapEventToState(AREvent event) async* {
    if (event is LoadPosts) {
      yield MarkerFound();
      await Future.delayed(Duration(milliseconds: 800));
      yield PostsLoading();
    }
    if (event is OpenCamera) {
      yield PostsLoading();
    }
    if (event is ReadyToShowPost) {
      readyToShowPosts = true;
      await Future.delayed(Duration(milliseconds: 1200));
      //yield PostsLoaded(posts: []);
    }
    if (event is ShowPosts) {
      if (!readyToShowPosts) {
        yield PostsLoading();
      } else {
        yield PostsLoaded(posts: []);
      }
    }
  }
}
