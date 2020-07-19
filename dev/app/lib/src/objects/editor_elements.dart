import 'package:flutter/material.dart';

class EditorText {
  TextEditingController controller;
  bool autofocus = true;
  bool saved = false;

  EditorText() {
    //controller.addListener(() {});
  }
}

class EditorImage {
  String url;
}
