import 'package:app/src/blocs/theme/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:app/src/design_system/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CTextField extends StatefulWidget {
  final String placeholder;
  final String text;
  final String title;
  final String validationMessage;
  bool isError;
  final bool autocorrect;
  final bool autofocus;
  final bool secure;
  final double hpadding;
  final Function(String) callBack;
  CTextField({
    Key key,
    this.placeholder,
    this.text,
    this.title,
    this.validationMessage,
    this.isError,
    this.autocorrect,
    this.autofocus,
    this.secure,
    this.hpadding,
    this.callBack,
  }) : super(key: key);

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<CTextField> {
  TextEditingController controller;
  double hPadding;
  bool isError;
  bool secure;
  bool autofocus;
  bool autocorrect;

  @override
  void initState() {
    print(widget.callBack);
    controller = TextEditingController();
    controller.addListener(() {
      if (widget.callBack != null) widget.callBack(controller.text);
    });
    if (widget.text != null) controller.text = widget.text;
    if (widget.hpadding == null)
      hPadding = 0;
    else
      hPadding = widget.hpadding;
    if (widget.isError != null)
      isError = widget.isError;
    else
      isError = false;
    if (widget.secure != null)
      secure = widget.secure;
    else
      secure = false;
    if (widget.autofocus != null)
      autofocus = widget.autofocus;
    else
      secure = false;

    if (widget.autocorrect != null)
      autocorrect = widget.autocorrect;
    else
      secure = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.isError != null)
        isError = widget.isError;
      else
        isError = false;
    });
    return BlocBuilder<ThemeBloc, ThemeEnum>(
      builder: (context, theme) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (widget.title != null)
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: CText(
                        (isError && controller.text.length > 4)
                            ? '*${widget.title}'
                            : '${widget.title}',
                        size: 16,
                        color: (isError && controller.text.length > 4)
                            ? Palette.textAccent
                            : Palette.textPrimary,
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
                      color: PaletteColor(
                        theme: theme,
                        type: Palette.textPrimary,
                      ).color,
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
                obscureText: widget.secure ?? false,
                autofocus: autofocus ?? false,
                autocorrect: autocorrect ?? false,
              ),
              (widget.validationMessage != null &&
                      isError &&
                      controller.text.length > 4)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: CText(
                          '${widget.validationMessage}',
                          size: 14,
                          color: Palette.accent,
                          weight: FontWeight.w600,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
