import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CText(
          'Prendi nota',
          size: 48,
          weight: FontWeight.w700,
        ),),
        Wrap(children: [
          CText(
          'Perchè non è sempre possibile ricordarsi tutto.',
          size: 20,
          weight: FontWeight.w700,
          color: Colors.black.withOpacity(0.7),
        ),
        ],),
        ],),
      ),
    );
  }
}
