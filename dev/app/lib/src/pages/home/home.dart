import 'package:app/src/blocs/language/index.dart';
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
          extendBody: true,
          body: Body(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.pushNamed(context, "/Camera");
            },
            tooltip: '${lang.script["camera_title"]}',
            child: Icon(Icons.add, color: Colors.white),
            elevation: 2.0,
          ),
          bottomNavigationBar: BottomBar(
            color: Colors.white,
            bgColor: Colors.black,
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
