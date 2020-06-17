import 'package:app/src/design_system/text.dart';
/// MIT License
/// by Andrea Buttarelli
/// creato il 05/06/2020
/// modificato il 05/06/2020

import 'package:app/src/objects/article.dart';
import 'package:flutter/material.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleObject post;

  const ArticleWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
          height: 240,
          decoration: BoxDecoration(
            color: Colors.black45,
            image: DecorationImage(image: NetworkImage('https://source.unsplash.com/random'), fit: BoxFit.cover,),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 4),
          child:CText(
          '${post.title}',
          size: 20,
          weight: FontWeight.w800,
        ),),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child:CText(
          'Yesterday',
          size: 14,
          weight: FontWeight.w600,
          color: Colors.black54,
        ),),
      ],) );
  }
}
