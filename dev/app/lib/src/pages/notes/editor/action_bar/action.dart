import 'package:app/src/design_system/palette.dart';
import 'package:flutter/material.dart';

class ActionIcon extends StatefulWidget {
  final IconData icon;
  final Function onClick;
  ActionIcon({Key key, this.icon, this.onClick}) : super(key: key);

  @override
  _ActionState createState() => _ActionState();
}

class _ActionState extends State<ActionIcon> {
  bool theme;

  @override
  Widget build(BuildContext context) {
    setState(() {
      theme = (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });

    return GestureDetector(
      onTap: () => widget.onClick(),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: (!theme)
              ? LightPalette().colors['${Palette.textSecondary20}']
              : DarkPalette().colors['${Palette.textSecondary20}'],
        ),
        child: Icon(
          widget.icon,
          size: 24,
          color: (!theme)
              ? LightPalette().colors['${Palette.textPrimary}']
              : DarkPalette().colors['${Palette.textPrimary}'],
        ),
      ),
    );
  }
}
