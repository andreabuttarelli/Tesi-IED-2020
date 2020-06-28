import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';

class ArticlePlaceholder extends StatelessWidget {
  const ArticlePlaceholder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentPlaceholder(
            height: 240,
            bgColor: Colors.black45,
            highlightColor: Colors.white,
            spacing: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: ContentPlaceholder(
              height: 16,
              bgColor: Colors.black45,
              highlightColor: Colors.white,
              spacing: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
              child: Container(
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 24,
            ),
            child: ContentPlaceholder(
              width: width / 3 * 2,
              height: 16,
              bgColor: Colors.black45,
              highlightColor: Colors.white,
              spacing: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
              child: Container(
                width: width / 3 * 2,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
