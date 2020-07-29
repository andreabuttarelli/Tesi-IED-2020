import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatefulWidget {
  Function onClick;
  GoogleSignInButton({
    Key key,
    this.onClick,
  }) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool isTapped = false;
  double opacity;
  bool theme;

  @override
  Widget build(BuildContext context) {
    if (isTapped)
      opacity = 0.5;
    else
      opacity = 1;

    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);

      /*if (widget.type == ButtonType.primarySolid ||
          widget.type == ButtonType.primaryStroke)
        color = (!theme)
            ? LightPalette().colors["textPrimary"]
            : DarkPalette().colors["textPrimary"];
      else if (widget.type == ButtonType.secondarySolid ||
          widget.type == ButtonType.secondaryStroke)
        color = LightPalette().colors["accent"];
      else if (widget.type == ButtonType.thirdSolid ||
          widget.type == ButtonType.thirdStroke)
        color = (!theme)
            ? LightPalette().colors["textPrimaryInverse"]
            : DarkPalette().colors["textPrimaryInverse"];*/
    });

    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: GestureDetector(
          onTapDown: (TapDownDetails details) => toogleTappedFlag(),
          onTapCancel: () => cancelTappedFlag(),
          onTapUp: (TapUpDetails details) => cancelTappedFlag(),
          onTap: () => widget.onClick(),
          child: AnimatedContainer(
            width: double.maxFinite,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child:
                  CText('Continue with Google', size: 18, color: Palette.black),
            ),
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
          ),
        ),
      ),
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
