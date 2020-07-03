import 'package:app/src/blocs/accessibility/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopIconBack extends StatefulWidget {
  Color color;
  IconData icon;
  Function voidCallback;
  TopIconBack({Key key, this.color, @required this.icon, this.voidCallback})
      : super(key: key);

  @override
  _TopIconBackState createState() => _TopIconBackState();
}

class _TopIconBackState extends State<TopIconBack> {
  bool isTapped = false;
  double opacity;

  @override
  Widget build(BuildContext context) {
    if (isTapped)
      opacity = 0.5;
    else
      opacity = 1;

    return BlocBuilder<AccessibilityBloc, bool>(
      builder: (context, isAccessible) {
        return Opacity(
          opacity: opacity,
          child: Container(
            padding: EdgeInsets.only(top: 24, left: 24, bottom: 16, right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                toogleTappedFlag();
              },
              onTapCancel: () => cancelTappedFlag(),
              onTapUp: (TapUpDetails details) => cancelTappedFlag(),
              child: Container(
                child: Icon(
                  widget.icon,
                  size: (isAccessible) ? 24 * 1.2 : 24,
                  color: widget.color,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  toogleTappedFlag() {
    setState(() {
      isTapped = true;
    });
  }

  cancelTappedFlag() {
    setState(() {
      isTapped = false;
    });
  }
}
