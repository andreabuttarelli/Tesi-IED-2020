import 'package:app/src/blocs/camera/index.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AndroidScanner extends StatefulWidget {
  AndroidScanner({Key key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<AndroidScanner> {
  ArCoreController arCoreController;
  Map<int, ArCoreAugmentedImage> augmentedImagesMap = Map();
  CameraBloc cameraBloc;

  @override
  void initState() {
    cameraBloc = BlocProvider.of<CameraBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*if (flagNavigation) {
      Navigator.pushNamed(context, '/Memories');
    }*/

    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        type: ArCoreViewType.AUGMENTEDIMAGES,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onTrackingImage = _handleOnTrackingImage;
    loadSingleImage();
  }

  loadSingleImage() async {
    final ByteData bytes =
        await rootBundle.load('assets/earth_augmented_image.jpg');
    arCoreController.loadSingleAugmentedImage(
        bytes: bytes.buffer.asUint8List());
  }

  /*loadImagesDatabase() async {
    final ByteData bytes = await rootBundle.load('assets/myimages.imgdb');
    arCoreController.loadAugmentedImagesDatabase(
        bytes: bytes.buffer.asUint8List());
  }*/

  _handleOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    if (!augmentedImagesMap.containsKey(augmentedImage.index)) {
      augmentedImagesMap[augmentedImage.index] = augmentedImage;
      cameraBloc..add(LoadPosts());
      //Navigator.pushNamed(context, '/Memories');
    }
  }

  /*Future _addSphere(ArCoreAugmentedImage augmentedImage) async {
    final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 1,
    );
    final node = ArCoreNode(shape: sphere);
    final node1 = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    final node2 = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(1, 0, 0),
    );
    final node3 = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0.3, -0.3, 0),
    );
    //arCoreController.addArCoreNodeToAugmentedImage(node, augmentedImage.index);
    arCoreController.addArCoreNode(node);
    arCoreController.addArCoreNode(node1);
    arCoreController.addArCoreNode(node2);
    arCoreController.addArCoreNode(node3);
  }*/

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
