import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc();

  @override
  CameraState get initialState => LookingForMarker();

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is LoadPosts) {
      yield MarkerFound();
      await Future.delayed(Duration(milliseconds: 800));
      yield PostsLoading();
    }
    if (event is OpenCamera) {
      yield PostsLoading();
    }
    if (event is ShowPosts) {
      await Future.delayed(Duration(milliseconds: 1200));
      yield PostsLoaded(posts: []);
    }
  }
}
