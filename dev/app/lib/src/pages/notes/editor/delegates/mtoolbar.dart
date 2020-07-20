import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import './formula-editor-widget.dart';
import 'package:app/src/components/zefyr/zefyr.dart';

class MDZefyrToolbarDelegate implements ZefyrToolbarDelegate {
  static const kDefaultButtonIcons = {
    ZefyrToolbarAction.bold: FeatherIcons.bold,
    ZefyrToolbarAction.italic: FeatherIcons.italic,
    ZefyrToolbarAction.link: FeatherIcons.link,
    ZefyrToolbarAction.unlink: FeatherIcons.link,
    ZefyrToolbarAction.clipboardCopy: FeatherIcons.copy,
    ZefyrToolbarAction.openInBrowser: FeatherIcons.externalLink,
    ZefyrToolbarAction.heading: Icons.format_size,
    ZefyrToolbarAction.bulletList: Icons.format_list_bulleted,
    ZefyrToolbarAction.numberList: Icons.format_list_numbered,
    ZefyrToolbarAction.code: Icons.code,
    ZefyrToolbarAction.quote: Icons.format_quote,
    ZefyrToolbarAction.horizontalRule: Icons.remove,
    ZefyrToolbarAction.image: Icons.photo,
    ZefyrToolbarAction.cameraImage: Icons.photo_camera,
    ZefyrToolbarAction.galleryImage: Icons.photo_library,
    ZefyrToolbarAction.hideKeyboard: Icons.keyboard_hide,
    ZefyrToolbarAction.close: Icons.close,
    ZefyrToolbarAction.confirm: Icons.check,
    ZefyrToolbarAction.values: []
  };

  static const kSpecialIconSizes = {
    ZefyrToolbarAction.unlink: 20.0,
    ZefyrToolbarAction.clipboardCopy: 20.0,
    ZefyrToolbarAction.openInBrowser: 20.0,
    ZefyrToolbarAction.close: 20.0,
    ZefyrToolbarAction.confirm: 20.0,
  };

  static const kDefaultButtonTexts = {
    ZefyrToolbarAction.headingLevel1: 'H1',
    ZefyrToolbarAction.headingLevel2: 'H2',
    ZefyrToolbarAction.headingLevel3: 'H3',
  };

  static const kExtend = {ZefyrToolbarAction.image: 'gey'};

  @override
  Widget buildButton(BuildContext context, ZefyrToolbarAction action,
      {VoidCallback onPressed}) {
    final theme = Theme.of(context);
    if (kExtend.containsKey(action)) {
      final icon = kDefaultButtonIcons[action];
      final size = kSpecialIconSizes[action];
      final theme = Theme.of(context);
      final width = theme.buttonTheme.constraints.minHeight + 4.0;
      final constraints = theme.buttonTheme.constraints.copyWith(
          minWidth: width, maxHeight: theme.buttonTheme.constraints.minHeight);
      final radius = BorderRadius.all(Radius.circular(3.0));

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ZefyrButton.icon(
            action: action,
            icon: icon,
            iconSize: size,
            onPressed: onPressed,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 6.0),
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0.0,
              constraints: constraints,
              onPressed: () async {
                final editor = ZefyrToolbar.of(context).editor;
                final image = (await editor.imageDelegate
                    .pickImage(editor.imageDelegate.gallerySource));
                if (image != null) {
                  editor.formatSelection(
                      NotusAttribute.embed.image('super' + image));
                }

                Scaffold.of(context).showBottomSheet((context) {
                  return Container(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Hey',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                });
              },
              child: Icon(Icons.add),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 6.0),
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(borderRadius: radius),
              elevation: 0.0,
              constraints: constraints,
              onPressed: () async {
                final editor = ZefyrToolbar.of(context).editor;
                // final image = (await editor.imageDelegate
                //     .pickImage(editor.imageDelegate.gallerySource));
                // if (image != null) {
                //   editor.formatSelection(NotusAttribute.embed.image('super'+image));

                // }

                Scaffold.of(context).showBottomSheet((context) {
                  return FormulaEditorWidget(
                    editor: editor,
                  );
                });
              },
              child: Icon(Icons.mic),
            ),
          ),
        ],
      );
    } else if (kDefaultButtonIcons.containsKey(action)) {
      final icon = kDefaultButtonIcons[action];
      final size = kSpecialIconSizes[action];
      return ZefyrButton.icon(
        action: action,
        icon: icon,
        iconSize: size,
        onPressed: onPressed,
      );
    } else {
      final text = kDefaultButtonTexts[action];
      assert(text != null);
      final style = theme.textTheme.caption
          .copyWith(fontWeight: FontWeight.bold, fontSize: 14.0);
      return ZefyrButton.text(
        action: action,
        text: text,
        style: style,
        onPressed: onPressed,
      );
    }
  }
}
