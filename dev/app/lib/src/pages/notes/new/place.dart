import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:app/src/objects/place.dart';
import 'package:app/src/pages/notes/editor/editor.dart';
import 'package:flutter/material.dart';

class PlaceWidget extends StatefulWidget {
  Place place;
  PlaceWidget({Key key, @required this.place}) : super(key: key);

  @override
  _PlaceWidgetState createState() => _PlaceWidgetState();
}

class _PlaceWidgetState extends State<PlaceWidget> {
  bool theme;

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Editor(
              place: widget.place,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: '${widget.place.id}',
              child: Container(
                width: double.maxFinite,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${widget.place.image}'),
                    fit: BoxFit.cover,
                  ),
                  color: (!theme)
                      ? LightPalette().colors["${Palette.backgroundSecondary}"]
                      : DarkPalette().colors["${Palette.backgroundSecondary}"],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Container(
              child: Wrap(
                children: [
                  CText(
                    '${widget.place.name}',
                    color: Palette.textPrimary,
                    size: 24,
                    weight: FontWeight.w500,
                    top: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
