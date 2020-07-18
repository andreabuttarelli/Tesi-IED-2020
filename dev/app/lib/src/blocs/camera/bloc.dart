import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc();

  @override
  CameraState get initialState => Undefined();

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is UpdateCameras) {
      yield (event.cameras.length != 0)
          ? Avaiable(cameras: event.cameras)
          : Undefined();
    }
  }
}
