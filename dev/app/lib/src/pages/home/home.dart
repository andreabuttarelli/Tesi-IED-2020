/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020

import 'package:flutter/material.dart';
import 'package:app/src/pages/home/bottombar/bottombar.dart';
import 'package:app/src/pages/home/bottombar/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/src/blocs/navigation/bloc.dart';
import './body.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomBar(
        items: [
          BottomAppBarItem(iconData: Icons.menu, text: 'News'),
          BottomAppBarItem(iconData: Icons.layers, text: 'Notes'),
        ],
      ),
    );
  }
}
