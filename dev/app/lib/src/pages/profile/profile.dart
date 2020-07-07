/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 04/07/2020

import 'package:flutter/material.dart';
import './body.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
