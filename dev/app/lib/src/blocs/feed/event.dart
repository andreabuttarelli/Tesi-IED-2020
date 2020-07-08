/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020

import 'package:equatable/equatable.dart';

abstract class FeedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends FeedEvent {}

class Restart extends FeedEvent {}
