import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';

class CTextField extends StatefulWidget {
  String placeholder;
  String text;
  String title;
  String validationMessage;
  bool isInitialError;
  bool autocorrect;
  bool autofocus;
  bool secure;
  double hpadding;
  CTextField({
    Key key,
    this.placeholder,
    this.text,
    this.title,
    this.validationMessage,
    this.isInitialError,
    this.autocorrect,
    this.autofocus,
    this.secure,
    this.hpadding,
  }) : super(key: key);

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<CTextField> {
  TextEditingController controller;
  double hPadding;
  bool isError;
  bool secure;

  @override
  void initState() {
    controller = TextEditingController();
    if (widget.text != null) controller.text = widget.text;
    if (widget.hpadding == null)
      hPadding = 0;
    else
      hPadding = widget.hpadding;
    if (widget.isInitialError != null) {
      if (widget.isInitialError)
        isError = true;
      else
        isError = false;
    } else
      isError = false;
    if (widget.secure != null) {
      if (widget.secure)
        secure = true;
      else
        secure = false;
    } else
      secure = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.title != null)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CText(
                    (isError) ? '*${widget.title}' : '${widget.title}',
                    size: 16,
                    color: (isError) ? Color(0xFFA92217) : Colors.black,
                    weight: FontWeight.bold,
                  ),
                )
              : Container(),
          TextFormField(
            controller: controller,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: "${widget.placeholder}",
              fillColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.25),
                  width: 2.0,
                ),
              ),
            ),
            obscureText: secure,
          ),
          (widget.validationMessage != null && isError)
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: CText(
                    '${widget.title}',
                    size: 14,
                    color: Color(0xFFA92217),
                    weight: FontWeight.bold,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
