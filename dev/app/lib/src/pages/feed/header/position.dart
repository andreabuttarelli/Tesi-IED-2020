import 'dart:async';
import 'package:app/src/blocs/position/index.dart';
import 'package:app/src/design_system/buttons/button.dart';
import 'package:app/src/design_system/buttons/dims.dart';
import 'package:app/src/design_system/buttons/type.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/objects/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class PositionWidget extends StatefulWidget {
  PositionWidget({Key key}) : super(key: key);

  @override
  _PositionState createState() => _PositionState();
}

class _PositionState extends State<PositionWidget> {
  PositionBloc positionBloc;
  bool theme;

  @override
  void initState() {
    positionBloc = BlocProvider.of<PositionBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    });
    return BlocBuilder<PositionBloc, PositionState>(
      builder: (context, state) {
        tempListen();
        if (state is Null) return Container();
        if (state is PlaceFound)
          return Container(
            width: double.maxFinite,
            height: 250,
            decoration: BoxDecoration(
              color: (!theme)
                  ? LightPalette().colors["Palette.backgroundSecondary"]
                  : DarkPalette().colors["Palette.backgroundSecondary"],
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRect(
              child: Stack(
                children: [
                  Positioned(
                    top: -17,
                    right: -25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              color: (!theme)
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(90),
                              image: DecorationImage(
                                  image: ExactAssetImage(
                                    (!theme)
                                        ? 'assets/img/near_location_light.png'
                                        : 'assets/img/near_location_dark.png',
                                  ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CText(
                          'Sei vicino a',
                          size: 16,
                          color: Palette.textSecondary70,
                          weight: FontWeight.normal,
                          top: 16,
                        ),
                        Container(
                          child: Wrap(
                            children: [
                              CText(
                                '${state.place.name}',
                                size: 32,
                                color: Palette.textPrimary,
                                weight: FontWeight.bold,
                                top: 8,
                                bottom: 24,
                              ),
                            ],
                          ),
                        ),
                        Button(
                          label: "Scopri di più",
                          color: Palette.textPrimary,
                          type: ButtonType.primaryStroke,
                          dims: ButtonDims.medium,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }

  tempListen() {
    //only with simulators
    positionBloc
      ..add(UpdatePosition(geopoint: GeoPoint(41.8853658, 12.4966204)));
  }

  listen() async {
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    StreamSubscription<Position> positionStream =
        geolocator.getPositionStream(locationOptions).listen(
      (Position position) {
        positionBloc
          ..add(UpdatePosition(
              geopoint: GeoPoint(position.latitude, position.longitude)));
      },
    );
  }
}
