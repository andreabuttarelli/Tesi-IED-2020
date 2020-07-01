import 'dart:ui';

import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class NormsWidget extends StatefulWidget {
  final Function onClick;
  NormsWidget({Key key, @required this.onClick}) : super(key: key);

  @override
  _NormsWidgetState createState() => _NormsWidgetState();
}

class _NormsWidgetState extends State<NormsWidget> {
  double opacity = 0.0;
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    if (isTapped)
      opacity = 0.5;
    else
      opacity = 1;

    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: Container(
        child: GestureDetector(
          onTapDown: (TapDownDetails details) => toogleTappedFlag(),
          onTapCancel: () => cancelTappedFlag(),
          onTapUp: (TapUpDetails details) => cancelTappedFlag(),
          onTap: () => widget.onClick(),
          child: AnimatedContainer(
            margin: const EdgeInsets.only(top: 24, bottom: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Color(0xFFffffff),
              boxShadow: [
                BoxShadow(
                  color: (isTapped)
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.1),
                  blurRadius: (isTapped) ? 0 : 8,
                  offset: Offset(0, -2),
                ),
                BoxShadow(
                  color: (isTapped)
                      ? Colors.transparent
                      : Colors.black.withOpacity(0.1),
                  blurRadius: (isTapped) ? 0 : 8,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Wrap(
                        children: [
                          BlocBuilder<LanguageBloc, Language>(
                            builder: (context, lang) {
                              return CText(
                                '${lang.script['banner_covid_title']}',
                                size: 20,
                                weight: FontWeight.w700,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      FeatherIcons.arrowRightCircle,
                      size: 28,
                    ),
                    /*CText(
                'Rispettiamo tutti le norme',
                size: 16,
                weight: FontWeight.w500,
              ),
              CText(
                'di sicurezza',
                size: 16,
                weight: FontWeight.w500,
              ),*/
                  ],
                ),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/norms.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
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
