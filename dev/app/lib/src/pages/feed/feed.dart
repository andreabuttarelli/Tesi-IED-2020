/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020
/// modificato il 05/06/2020
///
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './body.dart';
import 'package:http/http.dart' as http;
import 'package:app/src/blocs/feed/index.dart';

class Feed extends StatelessWidget {
  const Feed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Body();
  }
}
