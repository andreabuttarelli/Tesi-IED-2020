import 'package:app/src/blocs/language/index.dart';
import 'package:app/src/design_system/palette.dart';
import 'package:flutter/material.dart';
import 'package:app/src/pages/home/bottombar/bottombar.dart';
import 'package:app/src/pages/home/bottombar/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './body.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, Language>(
      builder: (context, lang) {
        return Scaffold(
          backgroundColor:
              (MediaQuery.of(context).platformBrightness == Brightness.dark)
                  ? DarkPalette().colors["Palette.backgroundPrimary"]
                  : LightPalette().colors["Palette.backgroundPrimary"],
          extendBody: true,
          body: Body(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            heroTag: 'FAB',
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.pushNamed(context, "/AugmentedReality");
            },
            tooltip: '${lang.script["camera_title"]}',
            child: Icon(Icons.add, color: Colors.white),
            elevation: 2.0,
          ),
          bottomNavigationBar: BottomBar(
            color: Colors.white,
            bgColor: Color(0xFF1D1D1D).withOpacity(0.8),
            items: [
              BottomAppBarItem(
                  iconData: Icons.menu, text: '${lang.script["feed_title"]}'),
              BottomAppBarItem(
                  iconData: Icons.layers,
                  text: '${lang.script["notes_title"]}'),
            ],
          ),
        );
      },
    );
  }
}
