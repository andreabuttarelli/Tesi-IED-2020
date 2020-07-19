import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import './index.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc();

  @override
  CameraState get initialState => Undefined();

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is Take) {}

    if (event is Save) {
      final currentState = state;
      if (currentState is Content) {
        if (currentState.isImage) {
          final isSaved = await GallerySaver.saveImage(currentState.url);
          yield Content(
              url: currentState.url,
              isImage: currentState.isImage,
              isSaved: isSaved);
        }
      }
    }
  }
}
