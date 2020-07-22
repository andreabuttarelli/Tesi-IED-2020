import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:app/src/blocs/camera/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/pages/augmented_reality/ui/looking.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:gallery_saver/gallery_saver.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _BodyState extends State<Body> with WidgetsBindingObserver {
  CameraController controller;
  String imagePath;
  String videoPath;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
  bool enableAudio = true;
  List<CameraDescription> cameras = [];
  bool cameraTaken = false;
  bool audioEnabled = true;
  bool isFilming = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    try {
      loadCameras();
    } catch (e) {
      print(e);
    }
    return Scaffold(
      key: _scaffoldKey,
      body: (cameras.length == 0)
          ? Container()
          : Stack(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Center(
                      child: _cameraPreviewWidget(),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
                _captureControlRowWidget(),
                _toggleAudioWidget(),
                /*Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //_cameraTogglesRowWidget(),
                      //_thumbnailWidget(),
                    ],
                  ),
                ),*/
              ],
            ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const CircularProgressIndicator(
        backgroundColor: Colors.white,
      );
    } else {
      final size = MediaQuery.of(context).size;

      // calculate scale for aspect ratio widget
      var scale = controller.value.aspectRatio / size.aspectRatio;

      // check if adjustments are needed...
      if (controller.value.aspectRatio < size.aspectRatio) {
        scale = 1 / scale;
      }
      return Transform.scale(
        scale: scale,
        child: Center(
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
        ),
      );
    }
  }

  /// Toggle recording audio
  Widget _toggleAudioWidget() {
    return Positioned(
      right: 24,
      top: 24,
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(27),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(27),
              ),
              child: Center(
                child: Icon(
                  FeatherIcons.mic,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            videoController == null && imagePath == null
                ? Container()
                : SizedBox(
                    child: (videoController == null)
                        ? Image.file(File(imagePath))
                        : Container(
                            child: Center(
                              child: AspectRatio(
                                  aspectRatio:
                                      videoController.value.size != null
                                          ? videoController.value.aspectRatio
                                          : 1.0,
                                  child: VideoPlayer(videoController)),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.pink)),
                          ),
                    width: 64.0,
                    height: 64.0,
                  ),
          ],
        ),
      ),
    );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: (isFilming)
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(27),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                            child: Container(
                              height: 10,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(27),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: LinearProgressIndicator(
                            minHeight: 10,
                            value: 0.3,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    )
                  : CText(
                      'hold to make a video',
                      size: 16,
                      color: Palette.white,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                /*IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),*/
                Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(27),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: Center(
                        child: Icon(
                          FeatherIcons.refreshCw,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Stack(
                  children: [
                    ClipPath(
                      clipper: InvertedCircleClipper(),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceIn,
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            (isFilming)
                                ? Color(0xFF4BC47C)
                                : Colors.transparent,
                            (isFilming)
                                ? Color(0xFF0ABAB5)
                                : Colors.transparent,
                          ]),
                          borderRadius: BorderRadius.circular(46),
                        ),
                        child: Container(
                          width: 92,
                          height: 92,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: ClipPath(
                        clipper: InvertedCircleClipper(),
                        child: new Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(42),
                          ),
                          child: Container(
                            width: 84,
                            height: 84,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: GestureDetector(
                        onTap: () {
                          print("picture");
                          if (controller != null &&
                              controller.value.isInitialized &&
                              !controller.value.isRecordingVideo)
                            onTakePictureButtonPressed();
                        },
                        onLongPress: () {
                          print("onLongPress");
                          if (controller != null &&
                              controller.value.isInitialized &&
                              !controller.value.isRecordingVideo)
                            onVideoRecordButtonPressed();
                        },
                        onLongPressEnd: (details) {
                          print("onLongPressEnd");
                          if (controller != null &&
                              controller.value.isInitialized &&
                              controller.value
                                  .isRecordingVideo) if (controller != null &&
                              controller.value.isRecordingPaused)
                            onResumeButtonPressed();
                          else
                            onPauseButtonPressed();
                          /*if (controller != null &&
                              controller.value.isInitialized &&
                              controller.value.isRecordingVideo)*/
                          //onStopButtonPressed();
                        },
                        onLongPressUp: () {
                          print("onLongPressUp");
                          if (controller != null &&
                              controller.value.isInitialized &&
                              controller.value
                                  .isRecordingVideo) if (controller != null &&
                              controller.value.isRecordingPaused)
                            onResumeButtonPressed();
                          else
                            onPauseButtonPressed();
                        },
                        child: Container(
                          width: 84,
                          height: 84,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (controller != null &&
                        controller.value.isInitialized &&
                        controller.value.isRecordingVideo)
                      onStopButtonPressed();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(27),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                      child: Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(27),
                        ),
                        child: Center(
                          child: Icon(
                            FeatherIcons.check,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),

                /*IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onVideoRecordButtonPressed
              : null,
        ),
        IconButton(
          icon: controller != null && controller.value.isRecordingPaused
              ? Icon(Icons.play_arrow)
              : Icon(Icons.pause),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  controller.value.isRecordingVideo
              ? (controller != null && controller.value.isRecordingPaused
                  ? onResumeButtonPressed
                  : onPauseButtonPressed)
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  controller.value.isRecordingVideo
              ? onStopButtonPressed
              : null,
        )*/
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    /*final List<Widget> toggles = <Widget>[];*/
    /*for (CameraDescription cameraDescription in cameras) {
      toggles.add(
        SizedBox(
          width: 90.0,
          child: RadioListTile<CameraDescription>(
            title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
            groupValue: controller?.description,
            value: cameraDescription,
            onChanged: controller != null && controller.value.isRecordingVideo
                ? null
                : onNewCameraSelected,
          ),
        ),
      );
    }
    return Row(children: toggles);*/
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: enableAudio,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          videoController?.dispose();
          videoController = null;
        });
        //if (filePath != null) showInSnackBar('Picture saved to $filePath');
        GallerySaver.saveImage('$filePath').then((path) => print('$path'));
      }
    });
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((String filePath) {
      if (mounted)
        setState(() {
          isFilming = true;
        });
      //if (filePath != null) showInSnackBar('Saving video to $filePath');
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted)
        setState(() {
          isFilming = false;
        });
      //showInSnackBar('Video recorded to: $videoPath');
      GallerySaver.saveVideo('$videoPath').then((path) => print('$path'));
    });
  }

  void onPauseButtonPressed() {
    pauseVideoRecording().then((_) {
      if (mounted)
        setState(() {
          isFilming = false;
        });
      //showInSnackBar('Video recording paused');
    });
  }

  void onResumeButtonPressed() {
    resumeVideoRecording().then((_) {
      if (mounted)
        setState(() {
          isFilming = true;
        });
      //showInSnackBar('Video recording resumed');
    });
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    await _startVideoPlayer();
  }

  Future<void> pauseVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.pauseVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.resumeVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> _startVideoPlayer() async {
    final VideoPlayerController vcontroller =
        VideoPlayerController.file(File(videoPath));
    videoPlayerListener = () {
      if (videoController != null && videoController.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) setState(() {});
        videoController.removeListener(videoPlayerListener);
      }
    };
    vcontroller.addListener(videoPlayerListener);
    await vcontroller.setLooping(true);
    await vcontroller.initialize();
    await videoController?.dispose();
    if (mounted) {
      setState(() {
        imagePath = null;
        videoController = vcontroller;
      });
    }
    //await vcontroller.play();
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  loadCameras() async {
    final camera = await availableCameras();
    setState(() {
      cameras = camera;
    });
    if (!cameraTaken) {
      if (controller != null && controller.value.isRecordingVideo) {
      } else {
        onNewCameraSelected(cameras[0]);
        setState(() {
          cameraTaken = true;
        });
      }
    }
  }
}
