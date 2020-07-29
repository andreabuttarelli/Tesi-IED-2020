import 'package:app/src/blocs/token/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './body.dart';
import 'package:app/src/pages/augmented_reality/apple/helmet.dart';

class AugmentedReality extends StatefulWidget {
  AugmentedReality({Key key}) : super(key: key);

  @override
  _AugmentedRealityState createState() => _AugmentedRealityState();
}

class _AugmentedRealityState extends State<AugmentedReality> {
  double opacity = 0;

  @override
  void initState() {
    opacity = 0;
    transition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TokenBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Hero(
              tag: 'FAB',
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
              ),
            ),
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(milliseconds: 600),
              child: Body(),
            ),
          ],
        ),
      ),
    );
  }

  transition() async {
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      opacity = 1;
    });
  }
}
